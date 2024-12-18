Return-Path: <linux-pci+bounces-18742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECB9F7124
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E44E18915C6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BD1FCF53;
	Wed, 18 Dec 2024 23:56:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67936192B94
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566162; cv=none; b=HpTf9pzFaZfBEIyaJDaoLH3tw4PTkOzZP2oMfpi8r6S6ZzcD9queAM+cBfoAvwT6QwvE8Efze058ZOCPjrFCuDiofy0wbxDmxFFg2YY5irkcP5+W6MWivoUPwpBKa5rpGuJlhdTQaG8spINi5r0ciD59iViLi9wVT6Jyd6c/vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566162; c=relaxed/simple;
	bh=sKk+8Pw4xSGfw8JaT/UTXckK2q4DXQMCQHu0GAX3w/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmWEF7+Fz8iL2pBxrehgVgbMxtcIJl4xOHy8Te4mY1QOfqebHEDUeh8LLh1Ug9XldneaKnMkwk9O+yQRvI8I33gITiE7E5AiLj0PnJl9HdLJkZtcrdCt5A4Mj78ftYH13TifoWxqP3XDRD7dh7hQ5oo5mgKQ+IrDHrFdJKekduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so2046555ad.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 15:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734566161; x=1735170961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvzgRlrU8ttMvKD4qWFFM+5fKSDvF9chRa42lMd5ahA=;
        b=Aw+Cv7pYGE3RF8+aLDF8Z2jMxk0VvPQ7hyg5qJxiwV32SjWRJVZVweKO42QofTxWJ1
         1DHFsd2dkUrUxtSNCelLVnOle8jWHCwEnbwERpJ+1VJKStxweNgR/beay9Sn2IK6amub
         hcCZTkdm10BIgA9FJrbplx52O1Am25EgMSDFeKUP/bZuM3DOJc4HuRKm4rM2dtIP5dp3
         nb2Sa6MGyyyAd9i4I62e9UDecb+09dhojpEdDu8jQhP9Gpjw9xNVNnZ6Air9TRiHWpfP
         W2eH09f5w7IhONo+ZQrcqaenUw0VEZOwxMPJ8q4ifc8nYo9blCiHCDK4FtaRWB9YMczq
         4+ow==
X-Forwarded-Encrypted: i=1; AJvYcCXxn4lZzFyRngnqdD3gs+vEoA0X0E80ZBC0wBBNVokiZ4NTWZG3CJC3exwQOrqkQVC48h2ZOf9siAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73JU2r3zt2wHyPveP3aivw22AswTvHrYRz6H7zxa/1Gqgg//0
	ht3ncW+lxpgaawanROWQtUH1kjUz5iLA0QF69BP/WR4Fdz6qeUFip9DJ/TJt
X-Gm-Gg: ASbGncsUcn9J3Nr7sVeAghprM35aAoFqcBU68H+c94AySvUQCq7eQDmnx1vNWAw0IqY
	BS5uj5bx3mzITTrKs0l5MVLqAoYkk5fVZXMHCauk0E3i8a2D+gs+2dFYB4onCA6W99gNAwlcAlz
	ygfLgkm5FW5ixsIzHILPWZq73ebMI0U2E/apAOGEmlMrL18nmr3qzBM28AkjEKrEt6+6lsKezXt
	3KF9xOW7zuGogFX52tn+pNCQYyO1xubOkN/c/NjMZSsR3yn3JdU6RgodAOboYnK6WATpD4s7ok8
	PBFSYYxtRKMoS4U=
X-Google-Smtp-Source: AGHT+IGVwTiZMzlaMFWBOIX9kzW5rbwVevRWkcY4MP1Q3g+2HBMXQZ1iYK96DBO8fGsS/AqyZtrbKQ==
X-Received: by 2002:a17:902:e74f:b0:215:6f5d:b756 with SMTP id d9443c01a7336-219d966e986mr16228035ad.7.1734566160693;
        Wed, 18 Dec 2024 15:56:00 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5dc5sm951005ad.210.2024.12.18.15.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:56:00 -0800 (PST)
Date: Thu, 19 Dec 2024 08:55:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/6] PCI endpoint additional pci_epc_set_bar() checks
Message-ID: <20241218235558.GD1444967@rocinante>
References: <20241213143301.4158431-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213143301.4158431-8-cassel@kernel.org>

Hello,

> This series adds some extra checks to ensure that it is not possible to
> program the iATU with an address which we did not intend to use.
> 
> If these checks were in place when testing some of the earlier revisions
> of Frank's doorbell patches (which did not handle fixed BARs properly),
> we would gotten an error, rather than silently using an address which we
> did not intend to use.
> 
> Having these checks in place will hopefully avoid similar debugging in the
> future.

Applied to endpoint, thank you!

[01/06] PCI: dwc: ep: Write BAR_MASK before iATU registers in pci_epc_set_bar()
        https://git.kernel.org/pci/pci/c/33a6938e0c33

[02/06] PCI: dwc: ep: Prevent changing BAR size/flags in pci_epc_set_bar()
        https://git.kernel.org/pci/pci/c/3708acbd5f16

[03/06] PCI: dwc: ep: Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()
        https://git.kernel.org/pci/pci/c/129f6af747b2

[04/06] PCI: artpec6: Implement dw_pcie_ep operation get_features
        https://git.kernel.org/pci/pci/c/b61fef0813cb

[05/06] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
        https://git.kernel.org/pci/pci/c/f015b53d634a

[06/06] PCI: endpoint: Verify that requested BAR size is a power of two
        https://git.kernel.org/pci/pci/c/0e7faea1880c

	Krzysztof

