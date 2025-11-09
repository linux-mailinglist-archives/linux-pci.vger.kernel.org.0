Return-Path: <linux-pci+bounces-40654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A2C442AF
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 17:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7130C4E2CA4
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F92FE56C;
	Sun,  9 Nov 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9RwGyyR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E901AA7BF;
	Sun,  9 Nov 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706955; cv=none; b=NwYCPQBRN6w1T70r/3YhgWRKOUoKJn2wKh5EetkjqIdjlra39+E7za9pTnX2FHuPYhVLOo5V09Bv7CLE5ArPWa2tCq1HUvZLqTPFWD/1HUTQYWHvxBVJXlRAU7M2ys0RsrvvBJj8ckL9yfWEtdpSNpO/o30sdLGPVo8WZ12jpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706955; c=relaxed/simple;
	bh=n4hSzcHd13twCNudNTmDw4sXbKY11Ss4Ov/R5YPLLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHWoBZK1BXE0EBbXOAVGQZ9e11LpN68VsxVGfua5Itwm80pDhrX28/hTm1aVWl1MV8qGQLIlRTewN0klnD3fbzFp09uKpuf6X2GUEdojX2VLiiKWAjS979aDQyfNWy4GytMmVmGtbxUo4d8F1u/uHeGXSAQrhx4DzPCHVvpCfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9RwGyyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B13C4CEF7;
	Sun,  9 Nov 2025 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762706954;
	bh=n4hSzcHd13twCNudNTmDw4sXbKY11Ss4Ov/R5YPLLzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9RwGyyRA/kvUZWhJ5Obm4NXxCl4uM4orfTPuniXCdZfAVOOzHZ9AJtzYDn9LefRh
	 JrCHXAYpxOesbk+4SZirluizDJPcZ4M/KXKJXVkDq2OPSZ0VooIlqmiCchzXVeQPo1
	 NiZvrUlAld7U8AJfIqWde+gCYMDVim8pSicYR8+NW8qIuZm2eTpuAmTJSgH73QY+nf
	 ZLvtPqNr5tE2wFohMEIJ37oxkFGp9I9Mg3oQ7a8y+VE3Lh3L455cJsqoyBtg+ut0ss
	 tDZsmllo/KU0y94eAGMXxaEbOJAblOTxQlDCDF5iZqpJrXb/NWXAadGl7XkcN4tf6a
	 ubAZJ6wX5K0Hw==
Date: Sun, 9 Nov 2025 22:18:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Enforce check for PHY,
 PERST# properties
Message-ID: <3wxfj3w2ilgmmmvntng4yohvorz3tn54egnyltg3dd3fwk67yq@f5p62em6sg2g>
References: <20251106-pci-binding-v2-0-bebe9345fc4b@oss.qualcomm.com>
 <20251106-pci-binding-v2-1-bebe9345fc4b@oss.qualcomm.com>
 <20251108-toad-of-hypothetical-opportunity-ebfa74@kuoka>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108-toad-of-hypothetical-opportunity-ebfa74@kuoka>

On Sat, Nov 08, 2025 at 12:59:50PM +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 06, 2025 at 04:57:16PM +0530, Manivannan Sadhasivam wrote:
> > Currently, the binding supports specifying the required PHY, PERST#
> > properties in two ways:
> > 
> > 1. Controller node (deprecated)
> > 	- phys
> > 	- perst-gpios
> > 
> > 2. Root Port node
> > 	- phys
> > 	- reset-gpios
> > 
> > But there is no check to make sure that the both variants are not mixed.
> > For instance, if the Controller node specifies 'phys', 'reset-gpios',
> 
> Schema already does not allow it, unless I missed which schema defines
> reset-gpios in controller node.
> 

'reset-gpios' is currently a valid property for both controller and Root Port
nodes. Where does the schema restricts it?

> > or if the Root Port node specifies 'phys', 'perst-gpios', then the driver
> > will fail as reported. Hence, enforce the check in the binding to catch
> > these issues.
> 
> I do not see such check.
> 

Don't you think the below required properties not enforce this check for Root
Port and Controller node? This atleast makes sure that if 'phys' is present,
'reset-gpios' would be required for Root Port and 'perst-gpios' is required for
Controller node.

> > 
> > It is also possible that DTs could have 'phys' property in Controller node
> > and 'reset-gpios' properties in the Root Port node. It will also be a
> > problem, but it is not possible to catch these cross-node issues in the
> > binding.
> 
> ... so this commit changes nothing?
> 
> The commit actually does change, but something completely different than
> you write here, so entire commit msg is describing entirely different
> cast. What you achieve here is to require perst-gpios, if controller
> node defined phys. Unfortunately your commit msg does not explain why
> perst-gpios are now required...
> 

The Qcom PCIe controller node never supported 'reset-gpios' for PERST#. It used
the 'perst-gpios' property instead. And I do not wanted to replace it with
'reset-gpios' property since we had decided to move PERST# to Root Port node,
where 'reset-gpios' is already the norm.

> > 
> > Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> That's too many tags. Either someone reported you bug or someone
> suggested you to do something, not both (and proposing solution is not
> suggesting a commit since you already knew you need to make the commit
> because of bug...)
> 

I disagree. Both Konrad and Krishna reported the issue in mixing up the
properties and driver ended up failing the probe. Then Dmitry suggested a schema
snippet [1] to catch these kind of mixups during DT validation. I did see it as
a valid suggestion that deserved the tag.

- Mani

[1] https://lore.kernel.org/linux-pci/qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3/

-- 
மணிவண்ணன் சதாசிவம்

