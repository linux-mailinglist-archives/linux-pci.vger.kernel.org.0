Return-Path: <linux-pci+bounces-41276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E47E2C5F61F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DC974E15BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516B35C185;
	Fri, 14 Nov 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa7dTlg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7A35BDBE;
	Fri, 14 Nov 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156141; cv=none; b=A6YkFlS+hl9cV1oepbTdk/ysx5mSxmSRihFO2JamnB6QwNd/AlV1HME8Y/y1nL2Jb7QBMjKl5iRMxrGisfnj/tEWLB8iPkHUsFb0q5jLinXuXXpsfD4lkjOA/PoHy2SQAcHNLPBReJ2xTcRJUixFqlF5hsWEewhd8znNY/TpSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156141; c=relaxed/simple;
	bh=7+gBsjbSf8GGUjKAhjC9BjsZi2tNC9506bmmv93MuO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dvk0B48e5j7p/q7IiRxb9agjg4fXrTGh5Iqfv0skMDO3Q92CBzc2wGA0DO2zrVu1C+cn/ioDErndJnXfDOgbG18sRbjk6E941z2vsifN+JzsQR5m88HbXP+Ds4+m3EkQZXbkcQWN5VCp8ux4GxxzpqmMp2BI16bPAXY0oIlIf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa7dTlg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615DFC4CEF1;
	Fri, 14 Nov 2025 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156141;
	bh=7+gBsjbSf8GGUjKAhjC9BjsZi2tNC9506bmmv93MuO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aa7dTlg+g4JoT9xX34DucEx0Z+AdddJdQXp3TRuzjqjFnyE4M4YPv4U6sDfQ8DaOS
	 mPBVLXkF4VNf1JKgb8ADAeETueV3PJuPCTVdDGIhEXCXM1PwjsP27s9Ci5IOrzqkYv
	 QNty5UnzGGK89TrFyWlCmjZpuq+Xin2YSIi/lXHdnA9eeuWV9SdXJNdeT5Gd9MbDSD
	 qQoW2iBN0NyKRzBoShc+ZNsj7izl4YfPU9R/fBWkVqcSeIjdO1QwhmDaN0RU5HfRmX
	 w0ATx4bBEOKtQgV6jE7HEhbXWn/qdxhmwbtQmFfMGvsib42qjUfT7N+Fiz5O4sW2ww
	 u7ueHayrsqO9g==
Date: Fri, 14 Nov 2025 15:35:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <20251114213540.GA2335845@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b945e463-52ec-417c-8e6a-599c35a6727d@foss.st.com>

On Fri, Nov 14, 2025 at 11:05:45AM +0100, Christian Bruel wrote:
> > > The implication is that *every* user of dw_pcie_suspend_noirq() would
> > > have to check for the link being up.  There are only three existing
> > > callers:
> > > 
> > >    imx_pcie_suspend_noirq()
> > >    ls_pcie_suspend_noirq()
> > >    stm32_pcie_suspend_noirq()
> > > 
> > > but none of them checks for the link being up.
> 
> stm32 supports L1.1, so we bail out before pme_turn_off() in
> dw_pcie_suspend_noirq()

I think you're referring to this code::

  dw_pcie_suspend_noirq()
  {
        /*
         * If L1SS is supported, then do not put the link into L2 as some
         * devices such as NVMe expect low resume latency.
         */
        if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
                return 0;

        if (pci->pp.ops->pme_turn_off) {
                pci->pp.ops->pme_turn_off(&pci->pp);
        } else {
                ret = dw_pcie_pme_turn_off(pci);
                if (ret)
                        return ret;
        }

I think this is bogus.  For starters, the code doesn't match the
comment.  The comment talks about "L1SS being supported", but the code
checks for L1 (not L1SS).  And it checks whether L1 is *enabled* (in
Link Control), not whether it's *supported* (in Link Capabilities).

And it's up to the user whether L1 is enabled.  Users can disable L1
by building the kernel with PCIEASPM_PERFORMANCE, booting with
"pcie_aspm.policy=performance", or using sysfs.

It doesn't make sense to me to decide anything about PME_Turn_Off
based on PCI_EXP_LNKCTL_ASPM_L1.

We've had this conversation before, e.g.,
https://lore.kernel.org/linux-pci/?q=b%3Adw_pcie_suspend_noirq+b%3ANVMe+f%3Ahelgaas,
and Richard actually posted a patch to remove this code [2], but I
hesitated because I didn't think we had a good explanation for why it
was there in the first place and it was now OK to remove it.

But I think I was wrong and we should just remove this code and debug
whatever breaks.

> > If no devices are attached to the bus, then there is no need to
> > broadcast PME_Turn_Off and wait for L2/L3. I've just sent out a
> > series that fixes it [1].  Hopefully, this will allow Vincent to
> > use dw_pcie_{suspend/resume}_noirq() APIs.
> >
> > - Mani
> > 
> > [1] https://lore.kernel.org/linux-pci/20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com/
> 
> dw_pcie_suspend_noirq() path tested OK on stm32mp2.
> 
> Regards
> 
> Christian

[2] https://lore.kernel.org/linux-pci/20250924194457.GA2131297@bhelgaas/

