Return-Path: <linux-pci+bounces-27743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED348AB716C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FED13A401D
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B601F1931;
	Wed, 14 May 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqhde4ps"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B517B425
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240351; cv=none; b=rxGP30gg+aj5fY+BNDo+E7MMjUcQEPy27DzOl0PhVIMCC0IpcsigLu2X5PKXh1C07fEtT4D3ZRHMeVQqujxcY7fW43V+DlJkw0Rv4VxXCPLcccT1tKBwM+cUeR09egOoiXTmO5wC6WaVTpSLUap5ZxSqQ+VM0vJA/jZSoqaY19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240351; c=relaxed/simple;
	bh=1N3x/GOevNWDg5nrpVSNIB9tY1j6A1Mn0q58cHpD7mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0/6jBe7F30erhuQGz/t0sBSVEaO03jdT+xNIXVydUMW1+WgnTM4i8nrM9DYJH6Ps5sQgX+P4wsmSPrYI9x/ZvaXRf3ADve/O06kWfuTsJjq8S3KaI/3ylBQN9jvhbQwPEUsuU7C+Actego1nSSLR/oA++OjeSOTovPNGju+xhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqhde4ps; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b646eff7so6091881f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747240348; x=1747845148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fnmo2+MZcpJ2cvX+WFzBsbU3N8d4JXlGi4Htr9EmUTs=;
        b=rqhde4psltSUx2l8eaFvCu2ZVjXeYPey8dGdXcQdBicQpeJe0yu+45FcLdYAY7Pm9H
         3CVpRola86z0/ipJ/5U/udmaIV5/77PzJF0mayxBNyfRkdM+MpOq+oRwFAGcmhNXl0Ee
         Yu+5h1RwYmbA2qOH611lBXLYO9/4eF5hT6OqGR9fWNo3DF3hFHvXpecrUepqWFxy8XJg
         HAgR+HHR9K6exqel9eaSRtyYAXImzz1PHY+9r/pXf5RMF+zls4xj5tUbP+wxCF6mPokn
         FumGX/CWW0dttd/PxMr3J7hxKCN1w3eeSdRWLLfFFUROgs6CbUHcj8Hm059VsUlSwo/Z
         aK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240348; x=1747845148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fnmo2+MZcpJ2cvX+WFzBsbU3N8d4JXlGi4Htr9EmUTs=;
        b=mfgDoHK0pGvHr66VR9R2N97Oze0kjnaDGCqPAQJDerJRnSQrH5oPUdXZhrfp8kkxu5
         f58jQMq8NTT0ZjA5JNVJk7WKDQnRFIefSaNKL7NxHrOquG9eSjOXB2ptE7QQjuAq12yR
         Z6asVgkVUoDBRBdJLyKZAbqVMn2lNLf+0IOJvqet4klxL1vQZ/+zIzBLCBbZHAbKyVCf
         lY5IDW5IsnDgDZJIl0s585LP5/H/o5wRgAPo//HcvteRjW/KntTWx8Zl5H6jP1KpnQq6
         FuPvZCbz5xdNf92rO4/GCjwBagET5Ys3Yt6siVyXvmjXsgsJ7KFrRq58m3QJHLMOc/ul
         tIZw==
X-Forwarded-Encrypted: i=1; AJvYcCXR/gugoPMR8vj5EzwRmNR0llMlofac9S7eOxf9Sm2jywRIp8CvbJd4FeE4Z0CQgTLDBtKk+Yof15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OU9HmPUV84xhhJst9Nm3fAtiD02dWMSOUwe4Aj/ZO93pv6J8
	EFMtn3D3LmhrR0Co3GXzoE7ri14lbe/oQhw8EJUvd3n9spb4HXpTA3GHGbG+Uw==
X-Gm-Gg: ASbGncvvNY9XAmiTnop+UuyeDvrqfK6yxjx7DuMcOVD/MisLfpNlj2cggSwT1qeikGw
	uff97ss9pzUkdFSZaFtzArLcE1qUumRYCsDvOSqhklcIRyIeZCQUk0zmV8riizOxOFgoeKJZYwq
	v6L3Zk+BqEiKL0xof93qfkxECYep+trdhVqYozgDeH3wL9WMz+KH4nESLBfgbSH1DS1zhgX3XOn
	iB7CwfkfI+LbUe3aEcTfRXuuR/1fUFtxdTNNJLnFA7G8nRgicYsRPKSQVwk5WztF3rZoCuG1Mhx
	GYB17wKyQ+BYFIKgFhOVXqZkcSpVjWL4qGWvnvO0QEYPbr0uiqtsexY9u4+Nzv+CWNGr+CIbrOb
	GVdIelVBtnlal7MjRM1hgRo6wsLYG0NPjOjv5VXd26WAk
X-Google-Smtp-Source: AGHT+IFn3vXnS6jxMSTKpvWwf0YAtvDrlGdswD18OpUum5KMQooxsvMQxaV39lTehJR9+Ij2bnRE1g==
X-Received: by 2002:a05:6000:4205:b0:3a0:a0d1:1131 with SMTP id ffacd0b85a97d-3a3496900a9mr3428305f8f.7.1747240348003;
        Wed, 14 May 2025 09:32:28 -0700 (PDT)
Received: from thinkpad.c.hoisthospitality.com (112.8.30.213.rev.vodafone.pt. [213.30.8.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb8c92d9sm37650875e9.2.2025.05.14.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:32:27 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dingwei@marvell.com,
	cassel@kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/5] PCI: Add support for resetting the slots in a platform specific way
Date: Wed, 14 May 2025 17:32:23 +0100
Message-ID: <174724032611.26337.10095399338390897616.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 May 2025 12:40:29 +0530, Manivannan Sadhasivam wrote:
> Currently, in the event of AER/DPC, PCI core will try to reset the slot and its
> subordinate devices by invoking bridge control reset and FLR. But in some
> cases like AER Fatal error, it might be necessary to reset the slots using the
> PCI host bridge drivers in a platform specific way (as indicated by the TODO in
> the pcie_do_recovery() function in drivers/pci/pcie/err.c). Otherwise, the PCI
> link won't be recovered successfully.
> 
> [...]

Applied, thanks!

[1/5] PCI/ERR: Remove misleading TODO regarding kernel panic
      commit: 0b56264b66b695aa76115ae68c1365dff80814e0
[2/5] PCI/ERR: Add support for resetting the slots in a platform specific way
      commit: e2889025d83fb38faac80d976f1789af3320ecb2
[3/5] PCI: host-common: Make the driver as a common library for host controller drivers
      commit: a811ffd43754dfcaccff497de1d8ee0bd30f8f2f
[4/5] PCI: host-common: Add link down handling for host bridges
      commit: f24509b96c33c1bdd9cc57bc4f8a58391e846c8c
[5/5] PCI: qcom: Add support for resetting the slot due to link down event
      commit: 40eba89968afc15302fa5aaef207fd9ccaf1ecb2

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

