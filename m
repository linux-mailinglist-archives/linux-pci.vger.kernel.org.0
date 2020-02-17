Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986ED16230F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 10:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgBRJKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Feb 2020 04:10:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgBRJKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2020 04:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gtxCElNvSCXWFICx33F89B+eF/cQ+L9FjqnWYk2rKuI=; b=h/D+gqw5OmQpGOwUjnu/fi4+kH
        bT0h8EUVx9iIS8HNfPlJzJPk40KKUsFKNf009z67RPKZuDo+88sdToDM6wpb5+YlEa7V9G6OJvFol
        R8RQl98kwCpA4ooFYQSURvPloAPXb0/KOMWODRXhBfm93RtLstFP639AaaseMhA7rBw6OI8LTEr+J
        PXc4gR41BMqKLfnINKvS8pLmCqR3uXPMYK/daZvPEV9ynEWBeYzh1jVee6AgvUIOeV700uQ2EOPBg
        z3vWEhpNHMY0ljZor0m1CokA7zJdOq2gDEs8oPaHQ9a9htLoD+FYLhrx/s8ITQGSuGwynWgVTIITp
        vszoRJOw==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3ytn-00046s-Vd; Tue, 18 Feb 2020 09:10:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j8V-000foa-PM; Mon, 17 Feb 2020 17:20:43 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        linux-crypto@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        keyrings@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        David Howells <dhowells@redhat.com>, linux-pci@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-pm@vger.kernel.org,
        Javi Merino <javi.merino@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 00/24] Manually convert  thermal, crypto and misc devices to ReST
Date:   Mon, 17 Feb 2020 17:20:18 +0100
Message-Id: <cover.1581956285.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Manually convert some files from thermal, crypto and misc-devices
to ReST format.

This patch is against linux-next 20200217 tag.

v2: 

- a small change at patch 2 to avoid uneeded whitespace changes;
- added 13 new patches at the end

Mauro Carvalho Chehab (24):
  docs: thermal: convert cpu-idle-cooling.rst to ReST
  docs: crypto: convert asymmetric-keys.txt to ReST
  docs: crypto: convert api-intro.txt to ReST format
  docs: crypto: convert async-tx-api.txt to ReST format
  docs: crypto: descore-readme.txt: convert to ReST format
  docs: misc-devices/spear-pcie-gadget.txt: convert to ReST
  docs: misc-devices/pci-endpoint-test.txt: convert to ReST
  docs: misc-devices/pci-endpoint-test.txt: convert to ReST
  docs: misc-devices/c2port.txt: convert to ReST format
  docs: misc-devices/bh1770glc.txt: convert to ReST
  docs: misc-devices/apds990x.txt: convert to ReST format
  docs: pci: endpoint/function/binding/pci-test.txt convert to ReST
  docs: arm64: convert perf.txt to ReST format
  docs: cpu-freq: convert index.txt to ReST
  docs: cpu-freq: convert amd-powernow.txt to ReST
  docs: cpu-freq: convert core.txt to ReST
  docs: cpu-freq: convert cpu-drivers.txt to ReST
  docs: cpu-freq: convert cpufreq-nforce2.txt to ReST
  docs: cpu-freq: convert cpufreq-stats.txt to ReST
  docs: cpu-freq: convert pcc-cpufreq.txt to ReST
  docs: powerpc: convert vcpudispatch_stats.txt to ReST
  docs: sh: convert new-machine.txt to ReST
  docs: sh: convert register-banks.txt to ReST
  docs: trace: ring-buffer-design.txt: convert to ReST format

 .../endpoint/function/binding/pci-test.rst    |  26 +
 .../endpoint/function/binding/pci-test.txt    |  19 -
 Documentation/PCI/endpoint/index.rst          |   2 +
 Documentation/arm64/index.rst                 |   1 +
 Documentation/arm64/{perf.txt => perf.rst}    |   7 +-
 .../{amd-powernow.txt => amd-powernow.rst}    |  12 +-
 Documentation/cpu-freq/{core.txt => core.rst} |  65 +-
 .../{cpu-drivers.txt => cpu-drivers.rst}      | 129 ++-
 ...pufreq-nforce2.txt => cpufreq-nforce2.rst} |  18 +-
 .../{cpufreq-stats.txt => cpufreq-stats.rst}  | 121 +--
 Documentation/cpu-freq/index.rst              |  42 +
 Documentation/cpu-freq/index.txt              |  56 --
 .../{pcc-cpufreq.txt => pcc-cpufreq.rst}      |  86 +-
 .../crypto/{api-intro.txt => api-intro.rst}   | 186 ++--
 ...symmetric-keys.txt => asymmetric-keys.rst} |  91 +-
 .../{async-tx-api.txt => async-tx-api.rst}    | 253 +++---
 ...{descore-readme.txt => descore-readme.rst} | 152 +++-
 Documentation/crypto/index.rst                |   5 +
 .../driver-api/thermal/cpu-idle-cooling.rst   |  18 +-
 Documentation/driver-api/thermal/index.rst    |   1 +
 Documentation/index.rst                       |   1 +
 .../{ad525x_dpot.txt => ad525x_dpot.rst}      |  24 +-
 .../{apds990x.txt => apds990x.rst}            |  31 +-
 .../{bh1770glc.txt => bh1770glc.rst}          |  45 +-
 .../misc-devices/{c2port.txt => c2port.rst}   |  58 +-
 Documentation/misc-devices/index.rst          |   6 +
 .../misc-devices/pci-endpoint-test.rst        |  56 ++
 .../misc-devices/pci-endpoint-test.txt        |  41 -
 .../misc-devices/spear-pcie-gadget.rst        | 170 ++++
 .../misc-devices/spear-pcie-gadget.txt        | 130 ---
 Documentation/powerpc/index.rst               |   1 +
 ...patch_stats.txt => vcpudispatch_stats.rst} |  17 +-
 Documentation/sh/index.rst                    |   6 +
 .../sh/{new-machine.txt => new-machine.rst}   | 193 +++--
 ...{register-banks.txt => register-banks.rst} |  12 +-
 Documentation/trace/index.rst                 |   1 +
 ...ffer-design.txt => ring-buffer-design.rst} | 802 ++++++++++--------
 37 files changed, 1603 insertions(+), 1281 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.rst
 delete mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt
 rename Documentation/arm64/{perf.txt => perf.rst} (95%)
 rename Documentation/cpu-freq/{amd-powernow.txt => amd-powernow.rst} (89%)
 rename Documentation/cpu-freq/{core.txt => core.rst} (69%)
 rename Documentation/cpu-freq/{cpu-drivers.txt => cpu-drivers.rst} (72%)
 rename Documentation/cpu-freq/{cpufreq-nforce2.txt => cpufreq-nforce2.rst} (55%)
 rename Documentation/cpu-freq/{cpufreq-stats.txt => cpufreq-stats.rst} (53%)
 create mode 100644 Documentation/cpu-freq/index.rst
 delete mode 100644 Documentation/cpu-freq/index.txt
 rename Documentation/cpu-freq/{pcc-cpufreq.txt => pcc-cpufreq.rst} (80%)
 rename Documentation/crypto/{api-intro.txt => api-intro.rst} (70%)
 rename Documentation/crypto/{asymmetric-keys.txt => asymmetric-keys.rst} (91%)
 rename Documentation/crypto/{async-tx-api.txt => async-tx-api.rst} (55%)
 rename Documentation/crypto/{descore-readme.txt => descore-readme.rst} (81%)
 rename Documentation/misc-devices/{ad525x_dpot.txt => ad525x_dpot.rst} (85%)
 rename Documentation/misc-devices/{apds990x.txt => apds990x.rst} (86%)
 rename Documentation/misc-devices/{bh1770glc.txt => bh1770glc.rst} (83%)
 rename Documentation/misc-devices/{c2port.txt => c2port.rst} (59%)
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.rst
 delete mode 100644 Documentation/misc-devices/pci-endpoint-test.txt
 create mode 100644 Documentation/misc-devices/spear-pcie-gadget.rst
 delete mode 100644 Documentation/misc-devices/spear-pcie-gadget.txt
 rename Documentation/powerpc/{vcpudispatch_stats.txt => vcpudispatch_stats.rst} (94%)
 rename Documentation/sh/{new-machine.txt => new-machine.rst} (73%)
 rename Documentation/sh/{register-banks.txt => register-banks.rst} (88%)
 rename Documentation/trace/{ring-buffer-design.txt => ring-buffer-design.rst} (55%)

-- 
2.24.1


