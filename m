Return-Path: <linux-pci+bounces-3052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA431847C7F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930F11F26070
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9868126F1E;
	Fri,  2 Feb 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmF2e0YQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91685933;
	Fri,  2 Feb 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913877; cv=none; b=kebS4idfBerhMpZ5AkIQiQONlKRHQs+0mymBO3z2lSNSJhCif2Ckx/OKWREt8s2dboJRXf5hqmYp9Ik1K1keYxrHeK+Kra38MZLqi6TkUHcla3aFLhaksc7UgbB/MIZ/x0CBqGhHmESr6GrjqvwrzW3+wE0zk171GMgyZfqyVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913877; c=relaxed/simple;
	bh=F0f3mIF6kNQTgYmfkHFIWR2e4gFbkQfXa2m81le8nLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gissrF4cM4z4rrvTn4eGQZYsNG2E349GHkILS0U3MzNRkPP1ZpW+YzX7OuJkTBomZzjgx7htTGiEo3j5ec7KTJHFnmvw2c0QbifV1W+dcZVXpdSkJ/q9i5SlSPIUGJBgPasyzX862haRU5muMHoG/2kZjJqOe+i+0Jsy43AtJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmF2e0YQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5113ab4ef05so885584e87.0;
        Fri, 02 Feb 2024 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706913874; x=1707518674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vVXVUVZFy6LOtqzDLB4UhBUfynLaccAy5a3T9ufPos=;
        b=YmF2e0YQePh85EqFpt6pyQNLcd/NQqtvbKFPCdeGBrU1ZTsJllb/vzttTWld/wokJ9
         pv6YRwNR/IPK+pDsoWYUDqIwUpKtFWu2Upxyztiivl8vuUJF6gVyFtq34o6uur0V2JyH
         SAEgC/C/EyW5mlkkVlXK/gjbJoMaqpec09UoXX2bBuk4uWWd7AT3n5+p2BvMvwXkrFlr
         4wjsf3pmkwMuUA42C6BnbVIDuuXrovPJHYw/vbqXv7uI6f7hb2Mj+gQY75NYC1L8xQfN
         3iWgtJCc+4MDaKfNCAb3boMGtSgo10DH6coRic60DUDXUEYouvKA6Yl1Dh+H8CZVzx8E
         3puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913874; x=1707518674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vVXVUVZFy6LOtqzDLB4UhBUfynLaccAy5a3T9ufPos=;
        b=RaSTLqHO2cqLyDa1udlMR1naxnZNHaXaU/Tgt+TaRUl8ZXWPwR7Ny09heOjNY/T6A1
         /nBPA9Ul0ZpcPvgQyMhoDoUIRNz/o+cWroQ15rzMyvu+QNJuR/WKgVz53h8DlovHgrw5
         xoYxicWELWWcEeuIfNziMYLMNO/551QMhTxFIiDOGMMBQT6UMkYtHlhjjIynRUas5WhA
         xFNox1dL0xPCWPxD931xhcaw1DEw+4arE3aL7qyYWFxHgog4zJE0yCybJJhMkaOgJArk
         IT1sZDypVAoLE1nF4CwH7bEedUW+60KEBno5N3Tcjo9kHf660vnpzb0Bqf+cLX/FBNEi
         LGXw==
X-Gm-Message-State: AOJu0YwHXPnQP1uJkdZYuh/eUuApmyH/HLOlaVxa3QSDbAOjMe4yYPof
	o/x7gct41YjRs54xvgiY4Qi0KMzjV5KJHD4Y6aiVzKKB9v0Xbvf++SnEhScEl7E=
X-Google-Smtp-Source: AGHT+IEOxWOFJPQvIYKMDswUkt17uWOHCphm942daxHLEHnaa2FX9s2cDvfQNs/oCGDGYJvFTXn47w==
X-Received: by 2002:ac2:5e79:0:b0:511:3a20:e116 with SMTP id a25-20020ac25e79000000b005113a20e116mr1504359lfr.11.1706913873840;
        Fri, 02 Feb 2024 14:44:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlxGb/q6EXr636pLRJcb7r2TsFDhV8wffFuzODQUkrYBKy06T6lufqZDnaBBfq5RgscpXT4INxjoyXrIAY3tFb3hiqgoNBHbx/bsgpoS7n7CZR2R1w0r3KvfrLx5HJkAcqtzc4omCeP5nJ/CgFygeFEfu258Sa/CXT3+ZtO5j6fJqsP71x+B+fve7ANOPMTvWwfDTVBdjFxB2RY2wDbec9QS1eyOUWhY1VWjESs5+rLrTqedSk4hjVQ6J+Qblj6QlaS4JpeXQxn4Lo8Q+3mifl5g5QrGR5x5DP8+Pn9b0gS/gDiVYJfUfplfurkzHKB1ngdgaAzPSHffJ1qA/ANRcfoIqcyeDeOlVeVc2eL7lBh6L5mJd3A97IxQJADDm0g4eDW+0EvFTEp22Gz1WND/HaS3bOtiCqLQOoMaAauJjna1DNhqUlNrI9AxWS2+CMEwxahOb4HtU/b2NJB3E=
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id u13-20020ac24c2d000000b0050eacc0c80bsm429821lfq.131.2024.02.02.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:44:33 -0800 (PST)
Date: Sat, 3 Feb 2024 01:44:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rob Herring <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>

On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> Add an outbound iATU-capable memory-region which will be used to send PCIe
> message (such as PME_Turn_Off) to peripheral. So all platforms can use
> common method to send out PME_Turn_Off message by using one outbound iATU.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 022055edbf9e6..25a5420a9ce1e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -101,6 +101,10 @@ properties:

>              Outbound iATU-capable memory-region which will be used to access
>              the peripheral PCIe devices configuration space.
>            const: config
> +        - description:
> +            Outbound iATU-capable memory-region which will be used to send
> +            PCIe message (such as PME_Turn_Off) to peripheral.
> +          const: msg

Note there is a good chance Rob won't like this change. AFAIR he
already expressed a concern regarding having the "config" reg-name
describing a memory space within the outbound iATU memory which is
normally defined by the "ranges" property. Adding a new reg-entry with
similar semantics I guess won't receive warm welcome.

-Serge(y)


>          - description:
>              Vendor-specific CSR names. Consider using the generic names above
>              for new bindings.
> 
> -- 
> 2.34.1
> 
> 

