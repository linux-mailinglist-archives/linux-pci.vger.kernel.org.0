Return-Path: <linux-pci+bounces-28775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA0AC9DF5
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86CC1781B3
	for <lists+linux-pci@lfdr.de>; Sun,  1 Jun 2025 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392319ADA2;
	Sun,  1 Jun 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMj4kdWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8F18BC2F
	for <linux-pci@vger.kernel.org>; Sun,  1 Jun 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761801; cv=none; b=tvzmDESGg3lk00fjeyCkZGpDcaTL3w0dKjgVMwRYJY1zwmtrTC0AU8y+LrDwIAVARkiilK7fZx5kjM0f/XDGKcpJATLwwLDUrpa594pBrm76qPiL0WbSMp8fUbfCPNOO2qbZMOm3t3SQtbM4jjROhKgn6SI/olB+156DxtBFFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761801; c=relaxed/simple;
	bh=BniQGKHAkLgDLs2FRxY0HczHo95+U/WuBwu2R5kKruU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCoHbD4ZuFWZwCs4uGvLN+UDPsmoNkE8OZF9zDYuhmpdy23IXnq53IRqEANrxeK2z9t2sQDVqKF74QUC8Qsm4HZj55975fpHgESHOSJUYqmm6eZ4AivDTG5SF1HqGnLxqCN8yFavMYz0CJATq2/krPWsUeSoydgjuCXoB2Tmiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMj4kdWx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234488c2ea6so35620305ad.3
        for <linux-pci@vger.kernel.org>; Sun, 01 Jun 2025 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748761798; x=1749366598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vx64ENds9yNKxmsf1fRcMvm79dh+K1dbdQlS0bVKK0Y=;
        b=VMj4kdWx9y4g1LAPRyWPA36Cni5v9Y2d+fm/dwEjbLK936N0BfG85lwxWIYm3R3uLe
         AitAket0Bl/RDG6snGcwNFW+y5ayNv0X6TDFJZhtefgp0Co8hgzY4JkR3iS8nv0heo2V
         v2mmHpaztpkrF6bRZjRPZrmHOZ1ehrP8wBH037kBqM/MrrQcZzpYmF8rh+m2Yk3K+Tjd
         sK0gVDd8An7AJybdt52hsDN7I7asu68drErcQe11RMRw5s2kSR93T48izY5MUsiYOFJk
         FVXly+9pCqNZtH5M9JeCdJ4dEMGFb4sFxywlzJPlGY3pdl5R4P/JizVq7UfdRQ3xIIXs
         6+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748761798; x=1749366598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx64ENds9yNKxmsf1fRcMvm79dh+K1dbdQlS0bVKK0Y=;
        b=uNssMPFUqZ1ukMVnhoV6PPWUV7btVHFz8LoQDbs6xpmInedNRsAUTxuIAVhOKkbbut
         r69XOU+nz7WQ7fDps+B4scb0UQUGJL5FnWcngpSPQHVkKEpa93V+haAsmUkLbhhLPPPz
         oxC2Q9f4yJ03QD+fDq4oJUf1hPrYev667pfAFygzpn96qgcCWgeb9U5tGk2kNIAtrV3Q
         YRTRqVF0DdUtl5hU6+X7Css3am60ajX2ggqmLuyWRlroPGByOy0pu6PCBcuNLYyTHrXd
         2goyUceub5MvxU2Ps068MOkjoU2uegCu0/enYx8qi09PRD03WKVCj3KI+E0NmEpkvV9M
         utgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPfjJQDDGa3kEjOMA92i+wH3b1SlAyKzFAyNXRmmgAfU+9yln+vM3+IJlFG5TtiKgy9HBFQw1awyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpblWLL7piJKRdvVsFZM6r2/urKbBgpOkHwhjIsNz/0sansN2K
	Bj2q1/EMaiRDOmxVEBnqAT5GJfstr84UWtxdVmq2N60VQeo9PpEmQFV5ablgCkJ16A==
X-Gm-Gg: ASbGncvhXJdXGRsccUcD9ac43oB5rmte1gJC60c8f8A9p8U9ub1QCg2e6DmXZ+v4XVQ
	qWJRfZ1nTOy5PW1yxlxZjmIy8W+zIsvL74z982v2FCIXP7sUyDGLFQCnu+NkCMgwiexL68tdt8A
	gpxyLCbH0bzUvNmGeNlK/7Rmr6U2Vr7tjXSWjXrY54q+1JpIoE/aUYN9OPaDMEGW8Ix1oCnJQ8h
	Wo3sC8GkHWFSG60c4ICavdWloCDPDKYC7HiyY8faSo/z8jwe8ghMrNUaYnnD2+Guf3TjqkRzJ/M
	rbVPK5FYekaXUNyIqNf9QWnjW//cEwPfsRPA6Itpbk0ItwxfIT6SzpBNAv8qHgQ=
X-Google-Smtp-Source: AGHT+IFeYi8cJujL8lmRCRg0ji+GV01N7Bx5JV9UOdvwJpxWWnAeTgjUtUNQwBUxCPsrEyGjoG+KDA==
X-Received: by 2002:a17:902:d4c8:b0:235:799:eca5 with SMTP id d9443c01a7336-2353961b5bemr123129935ad.44.1748761798352;
        Sun, 01 Jun 2025 00:09:58 -0700 (PDT)
Received: from thinkpad ([120.56.205.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc884dsm51805195ad.21.2025.06.01.00.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 00:09:58 -0700 (PDT)
Date: Sun, 1 Jun 2025 12:39:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 0/3] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
Message-ID: <7vw5pftnbiixxkokaebidfnjfs3nk6xoa7yaxxwmsssilfqnua@5qlbhqsiuojv>
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>

On Sat, Apr 19, 2025 at 10:49:23AM +0530, Krishna Chaitanya Chundru wrote:
> The main intention of this series is to move wake# to the root port node.
> After this series we will come up with a patch which registers for wake IRQ
> from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
> the host from D3cold. The driver change for wake IRQ is posted here[1].
> 
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[2] as the
> these properties are root port specific and does not belongs to
> bridge node.
> 
> So move the phy, phy-names, wake-gpio's in the root port.
> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> start using that property instead of perst-gpio.
> 
> For backward compatibility, don't remove any existing properties in the
> bridge node.
> 
> There are some other properties like num-lanes, max-link-speed which
> needs to be moved to the root port nodes, but in this series we are
> excluding them for now as this requires more changes in dwc layer and
> can complicate the things.
> 
> Once this series gets merged all other platforms also will be updated
> to use this new way.
> 
> Note:- The driver change needs to be merged first before dts changes.
> Krzysztof Wilczyński or Mani can you provide the immutable branch with
> these PCIe changes.
> 

Since there could be other patches for Qcom driver in the PCI tree, I don't
prefer immutable branch. Let's first merge the driver and binding patches
through PCI tree and you can submit the dts changes for rest of the platforms
for the next cycle.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

