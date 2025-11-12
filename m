Return-Path: <linux-pci+bounces-41017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80449C5465E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D51B4EE3DE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84C2BE7BA;
	Wed, 12 Nov 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cV7ndr+i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXud9P+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50382848B4
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978144; cv=none; b=qS1wItFHr6OjGYWKvuuh4b40xTeqQRgOQN8PB3+KkusBKgp0YwlYDs8YgaVq0U/eewtREAybkphDPayzcoK8FKJJe31Bi84MVhlzCildzibQRkjHM0zCFg7unCF3Nq1fGcMSoGs83xhr3V79lSqyWWHOZLLsL2U6d4cc9f8KFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978144; c=relaxed/simple;
	bh=pSfKi7QofeeoxWFt8fE1EwS0eMKYDkQjsuOeDlY4hz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrIH0e8lGCmg5jM3zOW3oo/458JLjJLl62VXaK50HfAL6Oy1PtXiK6Y8Lmez+lWW3qQrDf/fTRWWWak9KnoWP/hqcal00IvwteQlaTYqkpmMSHQf9HJa8ZMaZjCBdPgradNQg/SwRO31IyV5AEouiv3wFFfIKrX9wEJVEZ5g4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cV7ndr+i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VXud9P+v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACDsFrd1314305
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 20:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oU1WjTceS7iEoYjqJu8Zbfc7
	OQIDw2FU/7LRg8xG76s=; b=cV7ndr+icjg3VVH2aCSd81MsxEv0yfiNC+8vpfgO
	mvw8wdCt8mv3e5e6hervyN/igo5bv/dqpg3+1p0g8v9OkvcZsB6Buwbrxl/6G5s2
	4s6b6nlMTooBQdWDqPBBRpYN4OcY4tskLBiHKKSCNS8HNJHS6wGjpEI+iQA3DDSr
	o4hOr3A16UH40y3yDwVJwY5dXxAkEpB6qAXtldovfyCJ/q4XYgAA05wtIisKi9Am
	OaYHAku795OwAn8nH1E16CVpY5E3ee81XYwQNlP6XmDI+sQ8Hn9ccveF7VHvK3Zt
	PYf/0EDdNNPrOlECgdJ33rTOlMnAoly/qfD2cdCZ+mzEEg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuhg16wh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 20:09:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8916e8d4aso643851cf.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762978140; x=1763582940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oU1WjTceS7iEoYjqJu8Zbfc7OQIDw2FU/7LRg8xG76s=;
        b=VXud9P+veE9XHHD78ZGEMZQCjnLHntn0126KMpEWMRfRfh/M/vWMOOsCMEN8mTY73C
         I76qvEKS+PETy85PZE3OR5w6w01XpY9WGxdxnP1M0RU802YGvpBGLgc+0jHb2l5lc4gU
         CjbFjDrLrF/hLc+/sSH677wTNDccbdArjlNsPCJAPcFgfY4Vz4T9Vg4a9l5Du4xUtK2g
         GtfCrXuePCQxfdZ4l6z/+rANatxc8Q/2qdDZKGi3fycBrZhxkiBmtfm2iAljbnLF7FrV
         HRp1xbiq4sBCIa9xiGaoJ4Lx1loGXc+9ssMxWBezW9CyVjhj1nTdSwhlF7UxRHhjgndD
         juAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978140; x=1763582940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oU1WjTceS7iEoYjqJu8Zbfc7OQIDw2FU/7LRg8xG76s=;
        b=sxwN8jIGG98WpA2P/Mg2GMWyRhklRe5PAq2+HiR1n7CRH4Jg1F71q2U8vOWoR60ZsY
         uX9vNR5JoLtMv5IBEUfFF3N1FnsGfCODv+4kDDrmSnTVGS0izEzqirfPzfsozexb4nQV
         U6nDTj7+69jXHfvQGBGHOukbmib3PNO1eGC28XmNHxRtcqAciBLwjeGIjvRwscehroVO
         lESAgbVdwo6iekusLT1bgDXPy9kVvw7G5epFlpr+qARywE1ksNNc9DaHfSKgrVyaqLDo
         Nl0q1zHrzZDlBvA9DXbztXJdY36kV2Tf3ZrzsClmno+2XM1eSEMgbYdTUpxYSC7Sy3++
         eDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPm2pdpFigyLxS+Jc2P01E7UPYzPJwJ0Wm4DE23+kHIruiSkckwLQy4cGmKC9oG6+iUuHsdepp3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyC5yVtBBHnqCV9I/7T9k7qt4hn20xoGW+9t4F2BDzhZ2eUVLn
	Pv9Z2TVvfkDoRPpX/njG33q9wyOahrFKA6++XFrzqVMumqi96VKuSHXikaTtlizvbpGuBV6doPU
	G1yg9fYCqtujLOqXu5yB2RQWbjOo0dPBFqoqfRM2XKm6xTcGC0VyLs8L9geNp7so=
X-Gm-Gg: ASbGncsOipFHrcK92U1J17HhNntIN5u0eCG3nalH5KnW3uquMzYSeOkiFhTYHIZJpFt
	pUo8deN/N00EPGMcqQX4N3yNYgXM22bPUq0sG2IqL1vH/6UvTbna4izO2H/3Jj6A0WtlObkNGW5
	pRhgkSIqFxY2zPPzMfFZYTkichKMdJgaKqm4X6lZTcsDZMLnoyRONvXq/ByW01cTTR/l2uSzGvP
	vrsM/6HVf0bzaQnxpRhfVuPX7EYzKnYBFHQCSeqqbSVcMqIpl/Y80EIBPQry9lWVVRA4/du1cXu
	pgjd7kOKr2Bz/TYlIu3VN1IUoLtJA3cWl5dvpI9Rck3rCO0L7g2goD9hrFQ1Dw+qXW9UPvDZ8u6
	Dgh+6S4oGz6VhkATJI+yZUbHNVozYDtHDhzvLyjB5Nrko0iGHphRpg3i3BMGi6bxlqTm6iFln5j
	cNt6pBY9kcr50o
X-Received: by 2002:ac8:7f8e:0:b0:4eb:a2f0:356d with SMTP id d75a77b69052e-4eddbde1df0mr57234921cf.84.1762978140488;
        Wed, 12 Nov 2025 12:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY6kyZf9KAmfvVo/gfYCdU4m5A6XRB2OqUqHhgGCiTF3Gq4+27j12k14c35oXTx6DcTf1+mQ==
X-Received: by 2002:ac8:7f8e:0:b0:4eb:a2f0:356d with SMTP id d75a77b69052e-4eddbde1df0mr57234011cf.84.1762978139807;
        Wed, 12 Nov 2025 12:08:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b75bbsm6061720e87.61.2025.11.12.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:08:59 -0800 (PST)
Date: Wed, 12 Nov 2025 22:08:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH 7/9] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 E connector
Message-ID: <t45yq2cqj2t7lv4ifnvv556ewznjtzhdvvmofzgb5kcsarydqe@hxtonnejw6t7>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=NbnrFmD4 c=1 sm=1 tr=0 ts=6914e95d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=9n3VPyBaaxcwdMvd-aYA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: dDotg-WCvsIRoGrcwjiFAs7NIM6ZjZjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE2MiBTYWx0ZWRfX5bByswdjvlck
 xT4R8D9PZppvaHkEmM8w/4pvbSd1Ys0UsswZmSEnXvFZvI/adon5GaYlRHxao+PI+7Xz75LjKnU
 anTkzAufx9rbBw7muxGL+EEIa7bqI7/REfnSzBtvv+FfOoYEs82YTOCTRDQGSL+JzxM1rqglDl6
 2uMRnj47UIWAr4XIufpn5P3Iw0Njx27MD8C/rkdgF8/KTgZMWu5axfVAM53zPIrjVqgyBWfs8xf
 xo7+Q1zn6zNM9ilYVUoBI6hSmd04/lhwhqAg1ycpBH9fvxixDBmUsrgwpqyw8/gRGabXcFc142l
 vpU74nnN7vA+ANgIfrJWOiEpLPGVuOrK943sUK8h1b8Sajsamp0+D7WJKkixH26+z9CkjrNLMO2
 Di7VLnGY4UY8NxSYHtHc0rFCbI3v1w==
X-Proofpoint-ORIG-GUID: dDotg-WCvsIRoGrcwjiFAs7NIM6ZjZjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120162

On Wed, Nov 12, 2025 at 08:15:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices along with additional interfaces like I2C for NFC solution. At any
> point of time, the connector can only support either PCIe or SDIO as the
> WiFi interface and USB or UART as the BT interface.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 155 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..91cb56b1a75b7e3de3b9fe9a7537089f96875746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe/SDIO interface

The same comment as for the M-key bindings: please describe endpoints.

> +  led1-gpios:
> +    description: GPIO controlled connection to LED_1# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.

How are we supposed to handle these LEDs? I have been assuming that
these pins should go striaght to the LED driver.

> +    maxItems: 1
> +
> +  led2-gpios:
> +    description: GPIO controlled connection to LED_2# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO controlled connection to IO voltage configuration
> +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> +      host system that the card supports an independent IO voltage domain for
> +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> +      3.1.15.1 for more details.
> +    maxItems: 1

This more looks like viocfg-supply. Looking at this one and several
other pins, it's more like a GPIO controller, providing those pins for
the system, rather than a GPIO consumer.

> +
> +  uim_power_src-gpios:
> +    description: GPIO controlled connection to UIM_POWER_SRC signal. This signal
> +      is used when the NFC solution is implemented and receives the power output
> +      from WWAN_UIM_PWR signal of the another WWAN M.2 card. Refer, PCI Express
> +      M.2 Specification r4.0, sec 3.1.11.1 for more details.
> +    maxItems: 1
> +
> +  uim_power_snk-gpios:
> +    description: GPIO controlled connection to UIM_POWER_SNK signal. This signal
> +      is used when the NFC solution is implemented and supplies power to the
> +      Universal Integrated Circuit Card (UICC). Refer, PCI Express M.2
> +      Specification r4.0, sec 3.1.11.2 for more details.
> +    maxItems: 1
> +
> +  uim_swp-gpios:
> +    description: GPIO controlled connection to UIM_SWP signal. This signal is
> +      used when the NFC solution is implemented and implements the Single Wire
> +      Protocol (SWP) interface to the UICC. Refer, PCI Express M.2 Specification
> +      r4.0, sec 3.1.11.3 for more details.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key E connector for WLAN/BT with PCIe/UART interfaces
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    connector {
> +        compatible = "pcie-m2-e-connector";
> +        vpcie3v3-supply = <&vreg_wcn_3p3>;
> +        vpcie1v8-supply = <&vreg_l15b_1p8>;
> +        w_disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
> +        w_disable2-gpios = <&tlmm 116 GPIO_ACTIVE_LOW>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pcie4_port0_ep>;
> +                };
> +            };
> +
> +            port@3 {
> +                reg = <3>;
> +
> +                endpoint {
> +                    remote-endpoint = <&uart14_ep>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b3f689d1f50c62afa3772a0c6802f99a98ac2de..f707f29d0a37f344d8dd061b7e49dbb807933c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20478,6 +20478,7 @@ PCIE M.2 POWER SEQUENCING
>  M:	Manivannan Sadhasivam <mani@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
>  F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
>  F:	drivers/power/sequencing/pwrseq-pcie-m2.c
>  
> 
> -- 
> 2.48.1
> 
> 

-- 
With best wishes
Dmitry

