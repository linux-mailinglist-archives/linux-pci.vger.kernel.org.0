Return-Path: <linux-pci+bounces-36580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B3B8C403
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC4A1C0214E
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A4D285CAC;
	Sat, 20 Sep 2025 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f0r+2WO3"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8772405EB;
	Sat, 20 Sep 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357564; cv=none; b=dU6VhfoERwp3l9xDHwixHxje3nrjKNCgrzTH12ngT2uAft8HCtfg/jm7UVQDizWB/MEG087TfFMd5WK2ZhEvHyMRxWetSbN/aesSxf3N+JkdX8fP+503XkxeewNE0kiQbOqGBUe4DkzwRpP6/l0cubVHLWRW4UCjvRWtbBCnkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357564; c=relaxed/simple;
	bh=pqlHWu0kbkjsM+NySzj6K7DJFUheCj6/EzBpdVskemA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9f17S6BtfQkpznO7HYQnIK+mX1WshOeAcYkjKo7jjzoqOfSZRkcsibBCxURgpXCdPvcpPOQvSBvoe0E1q6hl5YyCt3ZdKRm7Q7pj6ee6EFMDNbZcanQJsBBdEAgCmeJILsKK3ql0Mi/8nBUxfbzPjyeG0SqMaB++fSUK81MmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f0r+2WO3; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58K8d0Yg863986;
	Sat, 20 Sep 2025 03:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758357540;
	bh=5P1VnkLxLWDtKO1OdbWD71wavzKd9UDxSmJcKsAEv1w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=f0r+2WO3HSPvdjAVpo9/DhvQX/kX0MmT8aHhL80bPFP4NKcYurL/nUkh6xuI6eN3w
	 3AYSuN1lxyiUOmjPI+8G+NzqiUxlB4BunAjchkkajyQwji4CTZs2FjgK3w7dPiNRkG
	 IiloSL4PJllShsFULRu+uLhy8b9z6wL1ApHVo0U8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58K8d0oR3515561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 03:39:00 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 03:38:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 03:38:59 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58K8cwbY3597808;
	Sat, 20 Sep 2025 03:38:59 -0500
Date: Sat, 20 Sep 2025 14:08:58 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <christian.bruel@foss.st.com>,
        <qiang.yu@oss.qualcomm.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <quic_schintav@quicinc.com>, <inochiama@gmail.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 09/10] PCI: keystone: Exit ks_pcie_probe() for the
 default switch-case of "mode"
Message-ID: <9d931573-5b23-44cf-8798-58715f9be699@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-10-s-vadapalli@ti.com>
 <lo2zv3nxek57s3h4hwv2ujzophdx2ubfuam4gqmo5h77t2g4jo@447qpc7a4ub3>
 <3f3b2f06-64a3-4e6d-9fa9-c3412b1ca710@ti.com>
 <jgw5f33ptz6dutffxaid4kxnllsdyanqy5obsotn3bmhxibxdt@2zzlh7mbfoi2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <jgw5f33ptz6dutffxaid4kxnllsdyanqy5obsotn3bmhxibxdt@2zzlh7mbfoi2>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Sep 20, 2025 at 01:57:34PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Sep 20, 2025 at 01:39:22PM +0530, Siddharth Vadapalli wrote:
> > On Sat, Sep 20, 2025 at 12:06:46AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Sep 12, 2025 at 05:46:20PM +0530, Siddharth Vadapalli wrote:
> > > > In ks_pcie_probe(), the switch-case for the "mode" is used to configure
> > > > the PCIe Controller for either Root-Complex or Endpoint mode of operation.
> > > > Prior to the switch-case statement for "mode" an invalid mode will result
> > > > in probe failure only if "dw_pcie_ver_is_ge(pci, 480A)" is true, which
> > > > is the case for the AM654 platform. On the other hand, when that is not
> > > > the case, "ks_pcie_set_mode()" will be invoked, which does not validate
> > > > the mode. As a result, it is possible for the switch-case statement for
> > > > "mode" to receive an invalid mode. Currently, an error message is displayed
> > > > in the "default" case where "mode" is neither "DW_PCIE_RC_TYPE" nor
> > > > "DW_PCIE_EP_TYPE", but the probe succeeds. However, since the configuration
> > > > required for Root-Complex and Endpoint mode have not been performed, the
> > > > Controller is not operational.
> > > > 
> > > > Fix this by exiting "ks_pcie_probe()" with the return value of "-EINVAL"
> > > > in addition to displaying the existing error message.
> > > > 
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > 
> > > Fixes tag? And probably CC stable since the controller seems to be not
> > > operations without this fix.
> > 
> > While I had mentioned the rationale for not including the 'Fixes tag' in
> > the v1 patch below the tearline, I forgot to add it in this patch. I will
> > quote the same below:
> > 
> >     NOTE: A "Fixes" tag is ommitted on purpose since the fix is not crucial:
> >     1. It doesn't fix a crash or any fatal error
> >     2. It doesn't enable controller functionality by fixing the issue
> > 
> 
> Fixes tag should be added irrespective of the cruciality of the bug.

Ok, I will include the tag in the v3 series.

> 
> >     Therefore, the patch may not be worth backporting.
> > 
> 
> Agree with this though.
> 
> > Prior to this patch, the probe succeeded and the controller was
> > unusable. Post this patch, the probe will fail and the controller is
> > still unusable. Behavior is identical from a usability perspective but
> > the user is aware of the issue since the probe fails.
> > 
> 
> Ok. I think the description could reworded to make it more clear. The actual
> issue is that the default case lacks setting the errno, leading to probe
> success. But the addition of ks_pcie_set_mode() and others seem to cause little
> bit confusion.

I will update the commit message and keep it concise to highlight the
issue. I understand that the additional information provided in order to
set the context might have been counterproductive.

Thank you for reviewing the patch and providing feedback.

Regards,
Siddharth.

