Return-Path: <linux-pci+bounces-42160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941BC8BA9D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 20:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4877E4F0BBC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56334CFB1;
	Wed, 26 Nov 2025 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d57oHvVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502034B683
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185801; cv=none; b=DG10reDENrrBFh5DvwghUbyLjPfLe0UXpKI3BNYQCapmUuct7FMpfR6/wmBuv+YplmTjYGlFzrCJiRH17+Rv0OXiUCbSp7X+jfwapQyhPpOdyGW9D015hmHeSppN3A5M3nsm42Ft/MsyN9I/iQJ2YoOVfiHH7k16Q0b6Tea3BbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185801; c=relaxed/simple;
	bh=VROY2nVPYZk7HCEafGudTR0uHJjXvZb2PCdkyXcjk7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LXaQpg9mlI0RKpUBsH/MnirIq0l+MKonBPK1/a9h1btbfNXlKk16xAvFyK0A6hR10G/8dGkfr8g7uCk7/ECgYugGRKDD1Bn1quvsizSh+uYw+7xhXWIcfk4/qdc6A8u2GgmVBuNkhwhIPJ/D9pQTWdid4YapTd0EzrGdOUg8fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d57oHvVc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b8b79cbd76so576515b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185798; x=1764790598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AglQTQPHcs2CoAEoAnmh5ycsdEepcN2ki5EQBy88w+U=;
        b=d57oHvVc/6WDHyZbceYYnuh5C7m2bimKY2G4L9k/ngbK+i8gtVmUkzUFoxwCBg2mcl
         TN6QtpyPIhWIKFLj0V6bTZa0IOrA888ZSdkeTWFAqJes2Iked6utR3Sh9y6X0T2GIEco
         o87/KFQW2j8/u9SlXEAtv/vQdtXVnMaArnyxMUazuz9hjgsIedlgLmlQJx6d3puihjFv
         LW3izZuZVFb3O+yQkxegEycoq/HFcnH778pzAVkYrwRSVegAKok8HEHGGo6wUAzwrRHF
         VXkSfVPMs6YLNsBFP7eKPq4gRQouy4YDlKW9rQtRQlkNzz9c6bVt3bFX9jMPypBiC/Ka
         XP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185798; x=1764790598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AglQTQPHcs2CoAEoAnmh5ycsdEepcN2ki5EQBy88w+U=;
        b=Yfm1+YlkkwbHTqgnbeJMZTiZoF9RkINAfvH3SJVqd3fiafg6SKzc9urrg/ZBmYbe9L
         3CBhVMnub99qZ1XBpO9hnR9FOdKufVhFdYADVZi1E2RxcUxx3DEKtNbXX/L/1VcckhKM
         INlDZN3ADpFAh3AgNOlJGFbX3b59svq26tVjkTt7hJWtqxv8tueCksCe+lC5zk/rClnp
         laGIMk9OsnOuGJyWogKco9aD2U9YVlR+K1k+xW7xg8w8tBwvzllHIQu7UY8nNk4u8Fas
         H1TcMqQX7+IRFgHdj1aDGl9L84hwpBTttug/3EH45RHAM+blysMCt9lHI9x6V9Dy1BR6
         0skg==
X-Forwarded-Encrypted: i=1; AJvYcCWU66DQEP9P4YiKjDg0Bwdnm1cHE6NqGAGWI0vZ8yc7LgBAl4ugD5gNYBWsdW6Wydn4tx3/G15+F/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTMhG/LNfb4k2aI1AjxPq7GqqgTbfStci1ayTfniR2OAqd79e
	ZCs6hx+XYNQMEb71ZhuTy1A/UfNXLHuecnN5xJbn1qG/xmDYVIrn/zKKfiPFn2r5wQbUnR9Qfsm
	afKgS7/ClMz1nwQ==
X-Google-Smtp-Source: AGHT+IHTAVGn798p3HwWv0BX7bvliQCFJ5hk7JsHWhTZ3epmSpJF+jTGo/Caibt0EEi13ZZvg8+CBEgvtlv2Hg==
X-Received: from pfoo16.prod.google.com ([2002:a05:6a00:1a10:b0:7b0:bc2e:9599])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3391:b0:35d:8881:e69b with SMTP id adf61e73a8af0-3614f4a255bmr24108621637.18.1764185797563;
 Wed, 26 Nov 2025 11:36:37 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:04 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-18-dmatlack@google.com>
Subject: [PATCH 17/21] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Add a selftest to exercise preserving a vfio-pci device across a Live
Update. For now the test is extremely simple and just verifies that the
device file can be preserved and retrieved. In the future this test will
be extended to verify more parts about device preservation as they are
implemented.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

To run this test manually:

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0

The second call to setup.sh is necessary because preserved devices are
not bound to a driver after Live Update. Such devices must be manually
bound by userspace after Live Update via driver_override.

This test is considered passing if all commands exit with 0.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-Developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 82 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 9b2a4f10c558..177aa5cd4376 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -6,6 +6,10 @@ TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
+# This test must be run manually since it requires the user/automation to
+# perform a kexec during the test.
+TEST_GEN_PROGS_EXTENDED += vfio_pci_liveupdate_kexec_test
+
 TEST_PROGS_EXTENDED := scripts/cleanup.sh
 TEST_PROGS_EXTENDED := scripts/lib.sh
 TEST_PROGS_EXTENDED := scripts/run.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..95644c3bd2d3
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+
+static const char *device_bdf;
+
+#define STATE_SESSION "567e1b8d-daf1-4a4a-ac13-35d6d275f646"
+#define DEVICE_SESSION "751ad95f-1621-4d68-8b5a-f9c2e460425f"
+
+enum {
+	STATE_TOKEN,
+	DEVICE_TOKEN,
+};
+
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	iommu = iommu_init("iommufd");
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, STATE_SESSION, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, DEVICE_SESSION);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Preserving device in session\n");
+	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int device_fd;
+	int stage;
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	VFIO_ASSERT_EQ(stage, 2);
+
+	session_fd = luo_retrieve_session(luo_fd, DEVICE_SESSION);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Finishing the session before retrieving the device (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Retrieving the device FD from LUO\n");
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	printf("Binding the device to an iommufd and setting it up\n");
+	iommu = iommu_init("iommufd");
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	printf("Finishing the session\n");
+	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return luo_test(argc, argv, STATE_SESSION, before_kexec, after_kexec);
+}
-- 
2.52.0.487.g5c8c507ade-goog


