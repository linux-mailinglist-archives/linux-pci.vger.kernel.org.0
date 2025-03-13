Return-Path: <linux-pci+bounces-23673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7EA5FCDE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940073B65A9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802B269AE6;
	Thu, 13 Mar 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLYiUOLA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52826988E;
	Thu, 13 Mar 2025 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885242; cv=none; b=Fz4wGTA6r5KtL3FYgxe0PjfKKt8bRZqR2Mwj6v6S7JcAzJqF5PSgctyB51fZTz2bVbmenTPbsoYVgUxKJIADJHzcUm4A3A1ppR1SD/6FgJZ3ZUBcq+lUxcCiCDE+mUGYAsypnA2Oll2H7sOBVpsTFilvxALhxBo1VOP3VWyvGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885242; c=relaxed/simple;
	bh=EXJ+N586JQssjnPiMNEZZP9DaYfkb1SKKIjIbSnTyW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XGV1wXhX7SEeiibHPH/KykRuAaRqG+IKQCKOs1m+Gdgpg/tXNYOqZ+NbKKlWjarHaLWbhrOV+01AFEEq/wF2QnROAh3AAHwfiNhQjKJX4zY4yPiTGglnNtiLDOdUdehs2LBnXRa6YDXGEwrj6p8FwbdIY1T6dEQbQF0xMZ9TpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLYiUOLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EEDC4CEDD;
	Thu, 13 Mar 2025 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885241;
	bh=EXJ+N586JQssjnPiMNEZZP9DaYfkb1SKKIjIbSnTyW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HLYiUOLAhys2tNUDg43JzjVkT5OLNJumHCaM11HBMEogUw3E6FGy14yuZq92QoILm
	 7Ee2uGorHbW1X1z18YQoawmbu8cZjSinqG5anNYFkTtkZEyEyD+7PXdwqrs8dL1t3V
	 JEQgov6oSVn3wfIUV+f8gvlqY/kjxDSxlACWGK/NtcSRClwgCf3rl/Eoj6L0WTJpjL
	 Q0+iN3fdGHl+6MLvhdYtrfUZBvQ8qJUFs4IDuEuU5Vrfn+R9lNaP6qypuFgHBMHo7X
	 XmRpeykE3+icblIB8GB9NlNvLMR/i6HI8HFSlU5e0NMIFl0Efrn4p2gZ2mGSVMndOA
	 XyQpzvcHWuZLQ==
Date: Thu, 13 Mar 2025 12:00:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2 01/10] PCI: update current bus speed as part of
 pci_bus_add_devices()
Message-ID: <20250313170039.GA738803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-mhi_bw_up-v2-1-869ca32170bf@oss.qualcomm.com>

s/update/Update/ in subject to match others

