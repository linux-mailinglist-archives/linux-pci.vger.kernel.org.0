Return-Path: <linux-pci+bounces-26279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4587AA942E5
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85EC3BAD3B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB91D5154;
	Sat, 19 Apr 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7xgxUNY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974281CD215
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059210; cv=none; b=Sq8OsxUM2OwZXzxk5FtjGz25y4eZK7DTShHnsY+//IHZYBXHKBjIBvSkAkikjdHBg6srRubISRoiMamHpt/aMCUh/t2hd53ho8B9E9EUyl8hWe0KCwjVAKrc7H+HbSnY75eH1MVuSHO91QgkqlMm8lxAZVUzxUntgdr5UIatMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059210; c=relaxed/simple;
	bh=F/8HfcwjCYVciaSf8sOnCLPv0Ch0D3Hd1xngEvK2sAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOLUJG4yOQCycGJTRLzBplC2Iz85J0x5xuksnNFiKeN0/Wr5mj3uro5F8bPZNuJatubofAJ/MtzWt04j2pTjDXXenHYMQEuPFGGZ2zgBaZpHpStu73Dy7EhA90E36+1uoC8vAxYPsTC/n3q10F7tn8o13x8cnEXxY5U6RKPObgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s7xgxUNY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso2497017a91.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745059208; x=1745664008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZZUE7lDwTEz2N4r/fX75wAzeLWxw2u+R07S3BlIwfA=;
        b=s7xgxUNYXmDzOJkBJBgVo6llKNEBvNeds4w9odsFAwqXWP1RlmfawngWLomgOqT1If
         adnhc7LoroqI2viuMaGQNtOlfJx0/Bi1vk/ovyQXHDxfq6fZ3v4/tLIVuKrg88Vv9xzg
         ZpS0WXHLeyedrSMf8gunZEtSd2OlFy2md5v09UJ999CK/l9ATi3WihclE1l3WNatxDuM
         q93gUe+7SOiwj+t+L3nw55UnLhspm4cG859YfZ6nJ96XgbpqHPDytcLlx6cTVGRJ7gTJ
         E2+GMdGGD87ra263RvIRZGDE2FyqlxkMzOQMntliS/uH1nmR2y9BFZ4LglmQbrWh6x+P
         I8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745059208; x=1745664008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZZUE7lDwTEz2N4r/fX75wAzeLWxw2u+R07S3BlIwfA=;
        b=GoXXDKj/IRwfZK8TIjEYNXRGI+UGS9PTC4T7dcNHNbvID3TtLy30T/QvG9NDhTqF5n
         xt/rFGTfJqxqMZR6ISvMGAyo2sGOEJc7SZirNsQBpAlTpYS3AS9dxIyI77hhVMuz0/n1
         EAeYHm6ZnkTqp0GMQpqUfxaMA5QPyR9Bas27Jv5iwB1Cm8qWYMbNmb9gbweS2W8Ya/m+
         c4t5Qz1oo9ASCjyhPS0hEAGiVQq1YzR7utB4ikhfjBu/ZsX/6F8HWwfoTb3dIuuGQp+Q
         M6q83wg7g2/7EhZGa3KNzMjagKZgoQCaUoZwXhT3qt3gLmxwaPhZNNHlgscCKd/C0zCp
         DBgA==
X-Forwarded-Encrypted: i=1; AJvYcCUHdaoaMnGvlYagogxoD1ZzEQj+UX9ogmsjkx4eTOWwnpPMA0x/vk03QcCfPLHnOrB7LTQpuSSXuTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjg47ro3o3/qaijrcHKN4nN9MzMepC0bmwY0NEiq6eRK1gI2Q
	ezci7U+ybIL+wst6kyH0AQlgCx17K5xqhK/fjZPMUOy18IyPRFwmGLSj4oMDdQ==
X-Gm-Gg: ASbGnctWYXRcJJCQw3FoKAx37a/eIbcN27advigJeBCUXV4ucWZOQ5LBkPuI787IZQQ
	aVasFzLLAvaYevOzZ3LpRCFyxUQJiCpQvHDXKMlWyhEiI1bKUCQr1qEh7ESAY3No0xPaQ+MkK9S
	genqen4MymeHLmx1NjSQwuZ8UOJNnhLrJBO4qyPbWGtpTbs0fu7ncDFUCQUSiZqiG4hpchC0vbh
	CXCnVDgu7vQnuHo8EBomwerQNcuavoFC8BXR3Im/869/XfZt+dSYW0WzYAz1YSDMWtpm/Zrke8s
	o+nSb68VHRlwRRrAMkbJ3YyXubJDe9GBSW1y7rZHSpTG3tSdHWEV1ZBofDAtOntH
X-Google-Smtp-Source: AGHT+IG48rfT7dO1+AZbhGTz/iIYddl71I2wayyAJZkp73FfKaGBUzoje28Z41u2PE9+dTi/GMGgcg==
X-Received: by 2002:a17:90b:57e6:b0:2ff:5016:7fd2 with SMTP id 98e67ed59e1d1-3087bbbfcb1mr8635818a91.24.1745059207952;
        Sat, 19 Apr 2025 03:40:07 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed23e3sm30785155ad.194.2025.04.19.03.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 03:40:07 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Correct indentation and style in DTS example
Date: Sat, 19 Apr 2025 16:09:44 +0530
Message-ID: <174505916020.32700.15920085651288867306.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
References: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Mar 2025 13:52:01 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: Correct indentation and style in DTS example
      commit: 37b52f92334c522d41c44ee4446e2a74cd830419
[2/2] dt-bindings: PCI: sifive,fu740-pcie: Fix include placement in DTS example
      commit: b3274b553aac4daddad998f426995b2388c8abb3

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

