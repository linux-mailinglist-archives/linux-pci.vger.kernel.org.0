Return-Path: <linux-pci+bounces-19920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E7A12A20
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2312C188B0DA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AA199EA3;
	Wed, 15 Jan 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3B5uUGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233E14A630
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963397; cv=none; b=KbibcgrNdq0hDtGsX5l2gFedt7tA7QgDKLHLDSjJdldjg5FgBah8xfMlsC45UljTWIYvzzALavXFeyGG9Z5+O9OlbkztZdQ9h4sVYggE4LJgUpEXkDTZ4rsxzAey+fr/gWBnfepNFU6x5/cfCka5ckdOl6zWshDDIw4QcBZaEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963397; c=relaxed/simple;
	bh=42rt7usybAFq/ouOmJ8Be4n15cxtqYeOsgIxc2xIiyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXwfv9HNZ0E2AikrA3gOszcvybIoFhJQqDyO2LSpERkmpUhExYrd1jg88ii/bhnSCM4gIss4I3XZATRlTyBSWvDOLPxI+hCLm2r3jbjLgrj+U9oAvukZRTn4g1kWs4r3cBMLTBQV91QiRcYsLQ0Pe8aSvtCRyveAVkuI2SegOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I3B5uUGK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so155413255ad.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736963395; x=1737568195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijQN8N59Y2kmAV+5Q+OaToHQ2NsmsUTEcGS96ikItDU=;
        b=I3B5uUGKbcSxCCW/Q1iioPH2gvbL/frf4qqEyl6SHpDEjvZo3gooarnx6ics+EFtnR
         dDHc1CSa08wFCZXHC/VMkG0PEvq4CEXqBSvESSPMXh2lyMrHhcSYEpT43BEuytE5g3ll
         HLlLaD54xPVL2BSmnLMeI1g2WFUZZIt8Mk67/Zznhd02+Je1blE+g3YdnsYi7W2nLKjB
         vJoKkOrsSPgYQIWkLvLQW7kaPRSJc4Oezs8c5b4LKBvfslTSvq2keBbz/zH4nXN/J66P
         YASd9zsGvSRDdiahI5K4k9e49cgTayJb4jvXFUSZcu88bjImpPRE7EiVT6Gli5YcHHN0
         TNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963395; x=1737568195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijQN8N59Y2kmAV+5Q+OaToHQ2NsmsUTEcGS96ikItDU=;
        b=qVouz9vGNZlo71SFDYLeuBICR0dIXKSsnlKU+mAxLovCBGRN5t4AB76OIXnsSlseiU
         +T1ykc6kYal6r5c/TSuO38kR/+6du51iGsH+yM1kmlHeyWKLC1ZwZLukf64d40RU3oEh
         IUbahz/LWj7NMwYipD8buV/MocREeXnQMF6yZYB/bgrGP8GTccEhKMS2fPzhsqgAHECO
         H09l7nLN+8UYNPCfZb0S5K+BFGEz/Fly2KO6TPkLktMHLh8/JjRRJTEN22AXL0tuktHC
         9EcUwyRzjfFQFf++edwIJTF4xWLVNJjzYK/WM+D8dOROG2GxQA9XWXREcyONt+wH9QtT
         gZbA==
X-Forwarded-Encrypted: i=1; AJvYcCW6iJnJyWfLY2qnwkGA00eDnJ7AhsiDeR8dNTA5SGdltvak5iT91La6YxTnOzKmmnp3ZEBVhQme5Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEtWK/5CzGgHUEKSLx7v6aWnCIuxBM7p1Q6tag/BhAjGTbXDm
	yRf+jaL989IevP95VB1mJej9yXj9Npx+D5T4dp1ogfwbvGRU9jNQExHYKx+q0Q==
X-Gm-Gg: ASbGncvTUeHLI45s87yJzCIZ4FuFdC8SS9qg55a5/sgTQph5/oEeUXmPQLDbRF49bWG
	oyJDKqqd/cuWGpGhbpATgkn3No8ZFQPPT1L0077iUiQ6wOpKg1QLXbMis0JQq7YlyhVemmDLazo
	OhKtkH77ztqeQJPq5MQu3fz6/OZVRgwX0jnMojIT92vBn4TJXmxsM698LYg16hVDXLqz04ZiCX1
	VO052Oc1lLOXLHB7vVlqICeUTPrDnDnf0eu2bspKmFGZmMgcz9IBv+DaaxDjv7KuEY=
X-Google-Smtp-Source: AGHT+IGnU19XoiVl4FcDEe9hTH4O9Bmvstejs7dclj+OyDqpDeZQevJgsHyuy7kvgQQPWQmodh2BBA==
X-Received: by 2002:a17:902:f68b:b0:216:55a1:35a with SMTP id d9443c01a7336-21a83f9cbedmr425818135ad.30.1736963395489;
        Wed, 15 Jan 2025 09:49:55 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12ff3fsm84488855ad.79.2025.01.15.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:49:53 -0800 (PST)
Date: Wed, 15 Jan 2025 23:19:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Anand Moon <linux.amoon@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <20250115174948.yippqwr5mekb6o4d@thinkpad>
References: <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch>
 <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
 <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch>
 <CANAwSgQ_gojVxvi_OyHTyTSdzRrno=Yymn0AdEXyTHTgDTyFcA@mail.gmail.com>
 <Z3vGXrUIII4ixNnF@ryzen>
 <b49e6147-32c6-4239-bdba-72f25ef04a9f@lunn.ch>
 <CANAwSgQqPREeFQisQZXqB52+w+j54Bwq4RMiHf3qUTXmnTxCAw@mail.gmail.com>
 <c08f3d69-1f3d-49a6-96ac-0c2f990f9a8d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c08f3d69-1f3d-49a6-96ac-0c2f990f9a8d@lunn.ch>

On Tue, Jan 07, 2025 at 02:13:34PM +0100, Andrew Lunn wrote:
> > I was just trying to understand the call trace for mdio bus which got
> > me confused.
> > 
> > [0] https://lore.kernel.org/all/Z3fKkTSFFcU9gQLg@ryzen/
> 
> There is nothing particularly unusual in there. We see PCI bus
> enumeration has found a device and bound a driver to it. The driver
> has instantiated an MDIO bus, which has scanned the MDIO bus and found
> a PHY. The phylib core then tried to load the kernel module needed to
> drive the PHY.
> 
> Just because it is a PCI device does not mean firmware has to control
> all the hardware. Linux has no problems controlling all this, and it
> saves reinventing the wheel in firmware, avoids firmware bugs, and
> allows new features to be added etc.
> 

Most of the time, it would be hard to define the properties of the PCI device's
internal bus in devicetree. For instance, the pinctrl/clock properties which
linux expects are to be connected to the host SoC, and not to the PCI device's
SoC (unless the whole device's SoC is defined).

Not saying that it is not possible but all, but very rare.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

