Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75AD3885C1
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhESDzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 23:55:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30910 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbhESDzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 23:55:09 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210519035348epoutp03cf81ff7cc533d3be4e6b5f566b8f01b8~AW3Ys-o5M0371903719epoutp03t
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 03:53:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210519035348epoutp03cf81ff7cc533d3be4e6b5f566b8f01b8~AW3Ys-o5M0371903719epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621396429;
        bh=ejJ6m0YKhV7mznOmQisAnxjSFqkE6Cy5x6zpEiFVMBw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PhiD9fWQuHy1fNLAs/3kkx1pHL2RxKfPe9bf63mQZWrCiz6a6jMxTe0nAeTcaZNoK
         UHbFsrZQWfL23H5aMAz2cLIPt4yWYAdo63tsCWgbr1KKdk4PLZ1KQEZZcH/lSGk8Nk
         l1Sq6wpi3TZYxKtrO2yIKmARcs6gtgzxmt+NlujM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210519035348epcas5p4d5536556475b0821ba237a3ff56c87b8~AW3X_ljXn2930029300epcas5p4i;
        Wed, 19 May 2021 03:53:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.D6.09835.CCB84A06; Wed, 19 May 2021 12:53:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210518173814epcas5p46b312c35e11c130a6a8d043f10d12ee4~AOd6m4Azr2230222302epcas5p4A;
        Tue, 18 May 2021 17:38:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210518173814epsmtrp1887537d5045ec4af4ca5ebae495e9038~AOd6mGNIZ2817428174epsmtrp1H;
        Tue, 18 May 2021 17:38:14 +0000 (GMT)
X-AuditID: b6c32a4b-7dfff7000000266b-57-60a48bcc8953
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.A6.08163.68BF3A06; Wed, 19 May 2021 02:38:14 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210518173812epsmtip18ff49cf50f4bfcf0c2809403cd9e6150~AOd4vc9462410324103epsmtip1C;
        Tue, 18 May 2021 17:38:12 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 0/3] Add support for RAS DES feature in PCIe DW controller
Date:   Tue, 18 May 2021 23:16:15 +0530
Message-Id: <20210518174618.42089-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCmuu6Z7iUJBocvslssacqw2HW3g93i
        47SVTBYrvsxkt7jz/AajxeVdc9gszs47zmbx5vcLdosnUx6xWhzdGGyxaOsXdov/e3awW/Qe
        rnXg9Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3p83iQXwB7FZZOSmpNZllqkb5fA
        lbHwxAnWghb+ij9nD7E3MC7i6WLk5JAQMJHobl/I1MXIxSEksJtR4taWA4wQzidGidnf10Fl
        PjNKXFq1nQ2m5ciZrywQiV2MEh1d+1khnBYmiWutz1hBqtgEtCQav3Yxg9giAtYSDa9WgRUx
        C8xhkvh/bBELSEJYwEti/ukGsLEsAqoSzw49BLN5Bawk7h39CLVOXmL1hgPMIM0SAo/YJe6v
        2s4IkXCRWH54P1SRsMSr41vYIWwpiZf9bVB2vsTUC0+BlnEA2RUSy3vqIML2EgeuzAELMwto
        SqzfpQ8RlpWYegrkZU6gMJ9E7+8nTBBxXokd82BsZYkvf/ewQNiSEvOOXWaFsD0kFp7cBHaZ
        kECsxITv89gnMMrOQtiwgJFxFaNkakFxbnpqsWmBcV5quV5xYm5xaV66XnJ+7iZGcArR8t7B
        +OjBB71DjEwcjIcYJTiYlUR4t3svThDiTUmsrEotyo8vKs1JLT7EKM3BoiTOu+Lh5AQhgfTE
        ktTs1NSC1CKYLBMHp1QD0+vt60on3RPRyvTpKbmZ/6R+xs/ApLBWV5/XvN43o+wbosIk+c/+
        sLnhLrTM4iH/BPZ7b0+4VLM2G1zJv99z/Y7dwUlh3Z8PsnfeLxXJcYqeaXtZ4NblmX+2qydq
        Kn9YtCLg3OklN/8skw6LdvZtj9/+2O/ixSCRGCfxx79z/oTJKD0/EDzryd/oti2mvmvOb/Rg
        mBETn5f64eymx9PSPySvunHlMYvy56p1URO5Kw5ujXq7a8LcGotfjy9KlnxuCP5y9ZSGzNfc
        lC87dkre8K/olL2vJVe4RtFvmqjZ0dO5G6bdTOELSz/Evtsw8r386QDF/x+jzO5sd28/eVL1
        8HP763W6kgW5vyObOnqU+JRYijMSDbWYi4oTAZjlZzuQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnG7b78UJBtM3c1osacqw2HW3g93i
        47SVTBYrvsxkt7jz/AajxeVdc9gszs47zmbx5vcLdosnUx6xWhzdGGyxaOsXdov/e3awW/Qe
        rnXg9Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3p83iQXwB7FZZOSmpNZllqkb5fA
        lbHwxAnWghb+ij9nD7E3MC7i6WLk5JAQMJE4cuYrSxcjF4eQwA5GiSObL7JBJCQlPl9cxwRh
        C0us/PecHaKoiUmieeVUsCI2AS2Jxq9dzCC2iICtRMPfDmaQImaBFUwSbWcms4AkhAW8JOaf
        bgBrYBFQlXh26CGYzStgJXHv6EeobfISqzccYJ7AyLOAkWEVo2RqQXFuem6xYYFRXmq5XnFi
        bnFpXrpecn7uJkZwQGpp7WDcs+qD3iFGJg7GQ4wSHMxKIrzbvRcnCPGmJFZWpRblxxeV5qQW
        H2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cC0WXSzJF+Xrb/7XskdGv7mfBHLq7d6
        6cWdbm//Xvwk8dG259ZcsVIhV/1j+eqmv9duM517ICz8+aee91pW7/4ZC8yVZ5eNOxvKeUpc
        peFl8PsNek8tJyl8e/zCubf6skNulw/X7YUzJEU3LZp4hfVUhLDmXaOyUA+dZ5sS3tsUrCxX
        E7l5rfdKVcYZtfqXvme+LdKe85rN++6CDf8Vdf199yZ/eup2IHbZka6QOcqnvf8c6Oxn2bBE
        iud0s5D9/LS2e1F7m1eLrOfsOiG5qGqluUvEioNWJie6FrhevuGmvyI36sTHR4vP1AYKHzG4
        KGuofe74sQ+vCqI5mROrLrvLdgoJ/m26rKBRsCRBrkCJpTgj0VCLuag4EQApp2ATtwIAAA==
X-CMS-MailID: 20210518173814epcas5p46b312c35e11c130a6a8d043f10d12ee4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210518173814epcas5p46b312c35e11c130a6a8d043f10d12ee4
References: <CGME20210518173814epcas5p46b312c35e11c130a6a8d043f10d12ee4@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare controller provides a vendor specific extended capability called
RASDES as an IP feature. This extended capability  provides hardware
information like:
 - Debug registers to know the state of the link or controller. 
 - Error injection mechanisms to inject various PCIe errors
including sequence number, CRC
 - Statistical counters to know how many times a particular event occurred

However, in Linux we do not have any generic or custom support to be able to
use this feature in an efficient manner. This is the reason we are proposing
this framework. Debug and bring up time of high-speed IPs are highly dependent
on costlier hardware analyzers and this solution will in some ways help to
reduce the HW analyzer usage.

The debugfs entries can be used to get information about underlying hardware
and can be shared with user space. Separate debugfs entries has been created to
cater to all the DES hooks provided by the controller. The debugfs entries
interacts with the RASDES registers in the required sequence and provides the
meaningful data to the user. This eases the effort to understand and use the
register information for debugging.

Shradha Todi (3):
  PCI: dwc: Add support for vendor specific capability search
  PCI: debugfs: Add support for RAS framework in DWC
  PCI: dwc: Create debugfs files in DWC driver

 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
 .../controller/dwc/pcie-designware-debugfs.h  | 133 +++++
 drivers/pci/controller/dwc/pcie-designware.c  |  21 +
 drivers/pci/controller/dwc/pcie-designware.h  |   5 +
 6 files changed, 713 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h

-- 
2.17.1

