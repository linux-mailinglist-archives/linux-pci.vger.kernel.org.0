Return-Path: <linux-pci+bounces-44948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84FD24ECC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6D1130208DD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CC3A1E69;
	Thu, 15 Jan 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBa1ZYUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2D3A1CE5
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487087; cv=none; b=tuCROC2uDin6yFQ8Erp5+Q6wOYq4llOrnQpCT1ozdJ385oBLjbahLniyHpNNSndZD/Qls0vCEXCrIqoG00HUcuY1KZ1iWV/hDd6iUMp6DpxSH3UfP/Wkqd8X3SDBv3vEYOID2eGzyaspkrs3uwpQJxJrV4r7zehoKR+awPPbJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487087; c=relaxed/simple;
	bh=prm75bBUvkddetwvbxbhROV7Sxy4F8UH6DE17vgNlvU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6yjJZXiBeCIXGp+KeEnKwekv08trrlttt45jZETWeLwmzoQoIbSdtVNgPVb+hcrMmvT5oKyjbvZC1xaEpQ27Py2V5XgkS92Vv2nwrdUxyRsbXNTFoPPjcL8q+f28H4kise3zXRXlxY+6kWGnIkmK/Ai/fU4GRHbfdXYu0Dl1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBa1ZYUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C71C116D0
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487086;
	bh=prm75bBUvkddetwvbxbhROV7Sxy4F8UH6DE17vgNlvU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=kBa1ZYUhsrdET57XNhhNJ39aLeU+zgI4NWtAjyWHQBaFYL4/+jQm5h64GEiemBQO2
	 Ma5TxbuZM3Hufel24TUFPM9ClkDUZoOdc7VUh/+tfbDR5nsskTBDoluBX7BHk+DARu
	 ym4/CXMKL/FVpGXVzhyDcCR/zoVjGj+lBzYqzG1wv8Swv44UReCQSaooV9vKV4EO6w
	 jlErYxGAtQ+DyHmuzj99lVkW4PsZkxj+3KYCAZCs61x7XZ1xwAcb7iw4G+wjDcKhLG
	 HwyKbCW2ipCqshfjY3Okm5yXaNulxPd1hw5wNnPTYheBCwIIKZVcVGppEqbDDdL0ZG
	 m9hi3OrQpTrPg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-382fb535b73so8039991fa.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9w/HGS5d3dIscqqZYhzwKx7TDNEOtlQ/ttMyo4NE8dh85Hw05xU0rjwx7gMRRP1R+4UbK1rrav3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOw3qk8I4hHPEdCNg0IlgTxqHAJXVwOHcJ7qfbBN1zecIAqnv
	KZHC27f931K9pvliINlh8jSJx5ImCI/b/L6Ic9JNvWFwOP1JDEHOkP/x0RNGcxpWbRvKdPm0U7u
	IAKyLIN2B/eDxnhDYFCPJcUpXvsWnv6HaRDORvUYB+w==
X-Received: by 2002:a05:651c:1443:b0:383:210a:7b35 with SMTP id
 38308e7fff4ca-3836078fd46mr23412681fa.36.1768487085519; Thu, 15 Jan 2026
 06:24:45 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:24:44 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:24:44 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-4-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-4-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 09:24:44 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeGNVVsdnynfaZ2xzmnH5BY7J+h6uN_NcsGEkZ_M72Siw@mail.gmail.com>
X-Gm-Features: AZwV_QhSqlo3D9V-01cFy2a2sAfzR08YDxZWC5KIr-GWSr6tSsU2qnVGsfYVy8Q
Message-ID: <CAMRc=MeGNVVsdnynfaZ2xzmnH5BY7J+h6uN_NcsGEkZ_M72Siw@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] PCI/pwrctrl: tc9563: Clean up whitespace
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 08:28:56 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Most of pci-pwrctrl-tc9563.c fits in 80 columns.  Wrap lines that are
> gratuitously longer.  Whitespace changes only.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

