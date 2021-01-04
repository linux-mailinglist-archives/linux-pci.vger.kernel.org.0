Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892BB2EA00F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 23:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbhADWd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 17:33:57 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:40124 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbhADWd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 17:33:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 9ACAD5E7;
        Mon,  4 Jan 2021 23:33:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fz4CyzIeWsiw; Mon,  4 Jan 2021 23:33:14 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BAE108A;
        Mon,  4 Jan 2021 23:33:14 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kwYPZ-000tPK-I9; Mon, 04 Jan 2021 23:33:13 +0100
Date:   Mon, 4 Jan 2021 23:33:13 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210104223313.plaaph3erefjw3rd@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
 <20210104213648.enkuq5e2o6adbiur@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104213648.enkuq5e2o6adbiur@function>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Samuel Thibault, le lun. 04 janv. 2021 22:36:48 +0100, a ecrit:
> Samuel Thibault, le lun. 04 janv. 2021 21:12:47 +0100, a ecrit:
> > Keith Busch, le lun. 04 janv. 2021 10:44:35 -0800, a ecrit:
> > > PCI also has automatic link power savings that you can disable with
> > > parameter "pcie_aspm=off".
> > 
> > I'll try that if I still see errors with the nvme_core parameter.
> 
> I'm on it.

(FTR It switched these lines)

02:00.0 Non-Volatile memory controller: Sandisk Corp WD Black SN750 / PC SN730 NVMe SSD (prog-if 02 [NVM Express])
	[...]
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		[...]
		DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
	->	DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
		DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
	->	DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
	[...]
	Capabilities: [100 v2] Advanced Error Reporting
		CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
	->	CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
	[...]
	Capabilities: [900 v1] L1 PM Substates
		[...]
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
			T_CommonMode=0us LTR1.2_Threshold=163840ns
		->	T_CommonMode=0us LTR1.2_Threshold=81920ns

Samuel
