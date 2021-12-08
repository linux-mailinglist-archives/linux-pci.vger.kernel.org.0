Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E479D46CA3B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 02:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbhLHBxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 20:53:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:11947 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243074AbhLHBxt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Dec 2021 20:53:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301117553"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="301117553"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 17:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="502857804"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2021 17:50:18 -0800
Received: from debox1-desk4.hsd1.or.comcast.net (unknown [10.251.18.198])
        by linux.intel.com (Postfix) with ESMTP id C53E55804B4;
        Tue,  7 Dec 2021 17:50:17 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH RESEND V2 6/6] selftests: sdsi: test sysfs setup
Date:   Tue,  7 Dec 2021 17:50:15 -0800
Message-Id: <20211208015015.891275-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208015015.891275-1-david.e.box@linux.intel.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tests file configuration and error handling of the Intel Software
Defined Silicon sysfs ABI.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V2
  - New patch

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 ++
 .../selftests/drivers/sdsi/sdsi_test.py       | 166 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ba9603fb7f62..3bc2a7bff168 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9788,6 +9788,7 @@ M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
 F:	samples/sdsi/
+F:	tools/testing/selftests/drivers/sdsi/
 
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
diff --git a/tools/testing/selftests/drivers/sdsi/sdsi.sh b/tools/testing/selftests/drivers/sdsi/sdsi.sh
new file mode 100755
index 000000000000..8db71961d164
--- /dev/null
+++ b/tools/testing/selftests/drivers/sdsi/sdsi.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the intel_sdsi driver
+
+if ! /sbin/modprobe -q -r intel_sdsi; then
+	echo "drivers/sdsi: [SKIP]"
+	exit 77
+fi
+
+if /sbin/modprobe -q intel_sdsi; then
+	python3 -m pytest sdsi_test.py
+	/sbin/modprobe -q -r intel_sdsi
+
+	echo "drivers/sdsi: ok"
+else
+	echo "drivers/sdsi: [FAIL]"
+	exit 1
+fi
diff --git a/tools/testing/selftests/drivers/sdsi/sdsi_test.py b/tools/testing/selftests/drivers/sdsi/sdsi_test.py
new file mode 100644
index 000000000000..fc99d9c23f51
--- /dev/null
+++ b/tools/testing/selftests/drivers/sdsi/sdsi_test.py
@@ -0,0 +1,166 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from struct import pack
+from time import sleep
+
+import errno
+import glob
+import os
+import subprocess
+
+try:
+    import pytest
+except ImportError:
+    print("Unable to import pytest python module.")
+    print("\nIf not already installed, you may do so with:")
+    print("\t\tpip3 install pytest")
+    exit(1)
+
+SOCKETS = glob.glob('/sys/bus/auxiliary/devices/intel_vsec.sdsi.*')
+NUM_SOCKETS = len(SOCKETS)
+
+MODULE_NAME = 'sdsi'
+DEV_PREFIX = 'intel_vsec.sdsi'
+CLASS_DIR = '/sys/bus/auxiliary/devices'
+GUID = "0x6dd191"
+
+def read_bin_file(file):
+    with open(file, mode='rb') as f:
+        content = f.read()
+    return content
+
+def get_dev_file_path(socket, file):
+    return CLASS_DIR + '/' + DEV_PREFIX + '.' + str(socket) + '/' + file
+
+class TestSDSiDriver:
+    def test_driver_loaded(self):
+        lsmod_p = subprocess.Popen(('lsmod'), stdout=subprocess.PIPE)
+        result = subprocess.check_output(('grep', '-q', MODULE_NAME), stdin=lsmod_p.stdout)
+
+@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
+class TestSDSiFilesClass:
+
+    def read_value(self, file):
+        f = open(file, "r")
+        value = f.read().strip("\n")
+        return value
+
+    def get_dev_folder(self, socket):
+        return CLASS_DIR + '/' + DEV_PREFIX + '.' + str(socket) + '/'
+
+    def test_sysfs_files_exist(self, socket):
+        folder = self.get_dev_folder(socket)
+        print (folder)
+        assert os.path.isfile(folder + "guid") == True
+        assert os.path.isfile(folder + "provision_akc") == True
+        assert os.path.isfile(folder + "provision_cap") == True
+        assert os.path.isfile(folder + "state_certificate") == True
+        assert os.path.isfile(folder + "registers") == True
+
+    def test_sysfs_file_permissions(self, socket):
+        folder = self.get_dev_folder(socket)
+        mode = os.stat(folder + "guid").st_mode & 0o777
+        assert mode == 0o444    # Read all
+        mode = os.stat(folder + "registers").st_mode & 0o777
+        assert mode == 0o400    # Read owner
+        mode = os.stat(folder + "provision_akc").st_mode & 0o777
+        assert mode == 0o200    # Read owner
+        mode = os.stat(folder + "provision_cap").st_mode & 0o777
+        assert mode == 0o200    # Read owner
+        mode = os.stat(folder + "state_certificate").st_mode & 0o777
+        assert mode == 0o400    # Read owner
+
+    def test_sysfs_file_ownership(self, socket):
+        folder = self.get_dev_folder(socket)
+
+        st = os.stat(folder + "guid")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "registers")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "provision_akc")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "provision_cap")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "state_certificate")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+    def test_sysfs_file_sizes(self, socket):
+        folder = self.get_dev_folder(socket)
+
+        if self.read_value(folder + "guid") == GUID:
+            st = os.stat(folder + "registers")
+            assert st.st_size == 72
+
+        st = os.stat(folder + "provision_akc")
+        assert st.st_size == 1024
+
+        st = os.stat(folder + "provision_cap")
+        assert st.st_size == 1024
+
+        st = os.stat(folder + "state_certificate")
+        assert st.st_size == 4096
+
+    def test_no_seek_allowed(self, socket):
+        folder = self.get_dev_folder(socket)
+        rand_file = bytes(os.urandom(8))
+
+        f = open(folder + "state_certificate", "rb")
+        f.seek(1)
+        with pytest.raises(OSError) as error:
+            f.read()
+        assert error.value.errno == errno.ESPIPE
+        f.close()
+
+        f = open(folder + "provision_cap", "wb", 0)
+        f.seek(1)
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.ESPIPE
+        f.close()
+
+        f = open(folder + "provision_akc", "wb", 0)
+        f.seek(1)
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.ESPIPE
+        f.close()
+
+    def test_registers_seek(self, socket):
+        folder = self.get_dev_folder(socket)
+
+        # Check that the value read from an offset of the entire
+        # file is none-zero and the same as the value read
+        # from seeking to the same location
+        f = open(folder + "registers", "rb")
+        data = f.read()
+        f.seek(64)
+        id = f.read()
+        assert id != bytes(0)
+        assert data[64:] == id
+        f.close()
+
+@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
+class TestSDSiMailboxCmdsClass:
+    def test_provision_akc_eoverflow_1017_bytes(self, socket):
+
+        # The buffer for writes is 1k, of with 8 bytes must be
+        # reserved for the command, leaving 1016 bytes max.
+        # Check that we get an overflow error for 1017 bytes.
+        node = get_dev_file_path(socket, "provision_akc")
+        rand_file = bytes(os.urandom(1017))
+
+        f = open(node, 'wb', 0)
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.EOVERFLOW
+        f.close()
-- 
2.25.1

