Return-Path: <linux-pci+bounces-35639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE7B48517
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A8817755D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88812E7637;
	Mon,  8 Sep 2025 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ+v4RB3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48062E718B;
	Mon,  8 Sep 2025 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316343; cv=none; b=KecgfNErD+Mtnff63YIHrj9cPcilrUIDYihW6cFNGxXIl5IHHp/p2mvSiy8VwKz5Hz4oLhO9gxpTPev96jVBhX2UmEO8zJ5833z5IiKr2YPLr/iDRej9tSxbOtc3XB/96+dzHgKcmho9HsGn5Du13FDvz8NvQzIu4cLYoP4ai1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316343; c=relaxed/simple;
	bh=0OrpL/DbISgvaSntm7MwE6vZ7KTvLFFuzrfYfkuRJhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzYHxIHzOnLWImv9/Zej1KGJSkZMYexB1hnufSmbBgYsxFjQChpzZ/Uz71GpVGRIHctQ/IKeWGRtMRpG70U0oH1efdyX+GEPVyA+z/EeYoxCXrGlQBygeXtsxMjkKEAOG+fzO8DEmztGzia6RpExUlDhzubjkoT5R1+RsHWK02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ+v4RB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD628C4CEF5;
	Mon,  8 Sep 2025 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757316343;
	bh=0OrpL/DbISgvaSntm7MwE6vZ7KTvLFFuzrfYfkuRJhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZ+v4RB3ujPkq4MZzpZj/xl+anJvRnWAyAmyBgubgwghU/s+EuciURemUbW9ZdM4o
	 QEWAmzE1mwM/5MsmrB3R0jf33mkyHH8JD3/YJiBp5NUab9gVK6EA278CiwONTgNKRz
	 pfwebdFq9IaYD1glCJukRv6xkAmKhCtEoHaVZ4j54gpm3XyofkN8pn/HrSc5MGc2gn
	 R4jigh9qx7NsNkLqyyb737FCFJAUZIZ6iIMp2fIBAG7iEJBg8nU8KN7+iaRtnpo+ex
	 MjH3kl/UeRBl1bf6tWmnnO05i4ACcNk4cn6vvhLxrp7qfzLXN/fW1sRPwxYIMDD/9M
	 6IVlAzfmjkvMA==
Date: Mon, 8 Sep 2025 12:55:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, 
	shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, 
	mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host
 controller driver
Message-ID: <ktpiiszfmtnvyh3yxchfqnpkfv43uxbke47vptexeg4tli2hmh@keifchvj44yj>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082405.1203-1-zhangsenchuan@eswincomputing.com>
 <jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi>
 <4fa48331.ce3.19913f1cc89.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fa48331.ce3.19913f1cc89.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Sep 04, 2025 at 04:57:17PM GMT, zhangsenchuan wrote:
> Dear Manivannan
> 
> Thank you for your thorough review.Here are some of my clarifications and questions.
> Looking forward to your answer, Thank you very much.
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > Send time:Monday, 01/09/2025 14:40:41
> > To: zhangsenchuan@eswincomputing.com
> > Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
> > Subject: Re: [PATCH v2 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host controller driver
> 
> 
> > > +	/* config eswin vendor id and eic7700 device id */
> > > +	dw_pcie_writel_dbi(pci, PCIE_TYPE_DEV_VEND_ID, 0x20301fe1);
> > 
> > Does it need to be configured all the time?
> 
> Clarification：
> Our hardware initialization did not configure the device Id and vendor Id.
> Now, we can only rewrite the device Id and vendor Id in the code.
> 

Ok. Then mention it in the comment itself. Like,

	/*
	 * Configure ESWIN VID:DID for Root Port as the default values are
	 * invalid.
	 */

> > 
> > > +
> > > +	/* lane fix config, real driver NOT need, default x4 */
> > 
> > What do you mean by 'readl driver NOT need'?
> > 
> 
> Clarification：
> Sorry, this was added during the compatibility platform test. It is not needed for real devices. 
> I will remove it later.
> 
> > > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> > > +	val &= 0xffffff80;
> > > +	val |= 0x44;
> > > +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> > > +
> > > +	val = dw_pcie_readl_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS);
> > > +	val &= ~(0x7 << 5);
> > > +	val |= (0x2 << 5);
> > > +	dw_pcie_writel_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS, val);
> > > +
> > > +	/*  config support 32 msi vectors */
> > > +	val = dw_pcie_readl_dbi(pci, PCIE_DSP_PF0_MSI_CAP);
> > > +	val &= ~PCIE_MSI_MULTIPLE_MSG_MASK;
> > > +	val |= PCIE_MSI_MULTIPLE_MSG_32;
> > > +	dw_pcie_writel_dbi(pci, PCIE_DSP_PF0_MSI_CAP, val);
> > > +
> > > +	/* disable msix cap */
> > 
> > Why? Hw doesn't support MSI-X but it advertises MSI-X capability?
> > 
> 
> I'm not quite sure what this comment means? Indeed, our hardware doesn't support MSI-X.

So it advertises MSI-X in capability by mistake then. If so, do you think it is
going to be applicable for future revisions of the controller also? I believe
this is a kind of hw bug.

Usually, these kind of issues are fixed in future revisions of the SoC. So I was
checking if you intend to clear it for all SoCs in the future or not. Otherwise,
you may set a flag and clear it conditionally.

> We can't disable the MSI-X capability using the PCIE_NEXT_CAP_PTR register? Then which 
> register is needed to disable the MSI-X capability?
> 

No, my question was not about *how to clear MSI cap*.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

