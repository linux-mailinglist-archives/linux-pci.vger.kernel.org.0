Return-Path: <linux-pci+bounces-10637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D05939C44
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D4728343E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA814BF89;
	Tue, 23 Jul 2024 08:09:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4714B97E;
	Tue, 23 Jul 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722180; cv=none; b=ZFJnlOauzYB7l78MYIWwjPdO/zqqoiSCxaFrYpvrddLcXboowwS4u9MvFeDMQpjIRoLvv88Wwm0wgy3kFqp0WGwSbEe/6gw8yRMJc01qoz5nafhWAOMVpWpC8aaS5C40t2+I/1j8EQfmXkPmYJVbKyKDGTjFec+fd+etiimZgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722180; c=relaxed/simple;
	bh=JsJYXjNIx7W5kl4D6KgJ2v6biHoChMoUlgJlPW7T69U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyeMecldWB1tp2DhMzEIQISZGrppiYXDJLI0reY/uFl76dHxU4RtEr8yKjTvTuzP2Ncto48qUhiWFmyn9tE6he/8SLyeiCr2NgFO/motB3U2f7WYKT2vcAtPB/Fj9e9Eq6gsL7TvPw0c5cDTd/I+QikWqSyKb7o9EDhUGw4BmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09341948|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0149439-0.000557638-0.984498;FP=3697210579835616410|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.YX7xuQS_1721721843;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YX7xuQS_1721721843)
          by smtp.aliyun-inc.com;
          Tue, 23 Jul 2024 16:04:04 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: Re: [PATCH v4] Subject: PCI: Enable io space 1k granularity for intel cpu root port
Date: Tue, 23 Jul 2024 08:04:03 +0000
Message-Id: <20240723080403.9764-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712184849.GA330337@bhelgaas>
References: <20240712184849.GA330337@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


> I think this has potential.  Can you include a more complete citation
> for the Intel spec?  Complete name, document number if available,
> revision, section?  Hopefully it's publically available?

Most of intel CPU EDS specs are under NDA. But you can refer to
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-v2-datasheet-vol-2.pdf
keyword:"EN1K".

> + /*
> > + * Per intel sever CPU EDS vol2(register) spec,
> > + * Intel Memory Map/Intel VT-d configuration space,
> > + * IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
> > + * bit 2.
> > + * Enable 1K (EN1K):
> > + * This bit when set, enables 1K granularity for I/O space decode
> > + * in each of the virtual P2P bridges
> > + * corresponding to root ports, and DMI ports.
> > + */
> > + while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> 
> To be safe, "d" (the [8086:09a2] device) should be on the same bus as
> "dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
> which would be a different bus, and they presumably are not influenced
> by the EN1K bit.

I modified the code as follows, can you help me review it? 

/* Enable 1k I/O space granularity on the intel root port */
static void quirk_intel_rootport_1k_io(struct pci_dev *dev)
{
	struct pci_dev *d = NULL;
	u16 en1k = 0;

	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
		return;

	/*
	 * Per intel sever CPU (ICX SPR GNR)EDS vol2(register) spec,
	 * Intel Memory Map/Intel VT-d configuration space,
	 * IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
	 * bit 2.
	 * Enable 1K (EN1K):
	 * This bit when set, enables 1K granularity for I/O space decode 
	 * in each of the virtual P2P bridges
	 * corresponding to root ports, and DMI ports.
	 */
	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
		if (pci_domain_nr(d->bus) == pci_domain_nr(dev->bus)) {
			pci_read_config_word(d, 0x1c0, &en1k);
			if (en1k & 0x4) {
				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
				dev->io_window_1k = 1;
			}
		}
	}
}
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,	quirk_intel_rootport_1k_io);

If you have a better method, please let me know. If there are no issues, 
I can submit a new patch.

