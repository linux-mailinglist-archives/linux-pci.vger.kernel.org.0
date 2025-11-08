Return-Path: <linux-pci+bounces-40642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE8C432E6
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 19:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E38F04E189F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11C24C676;
	Sat,  8 Nov 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ML3sUk6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCb2V+O/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC724337B
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625462; cv=none; b=tvl4mBiFmJSBaUf+2FxHf+HFgNDv7c92u02JxxFrCXs4jhtv7K4gYcSG2rLEKQs8YKmB+KbN0n/Y2vGq4gxOcnYJ70hMg2HTBhxdEc2amY1lTs3Uw88pELnysP6pOPn3+oknr6b+wf9rgsIpVcMqmmoiOlvQMnBaupraXRqc9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625462; c=relaxed/simple;
	bh=fOsRuEG19Rm3C05snWo9jA5gpWqRYP4hAH53HLRrD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnzG1KjGKejni7oPWbbZ1CjIAYXyoFBy6PhJqZi0d34KL0Be4cmC5cR+1oI2L+hLwqlx7wgxnCfj+xXYcNQ2QE2HrSUWKv4VnPAUOYC0RL+rQ+IsmZ2WCJNNjpmxmecmAmhHNiYPRQLOmqN9Tc8D0cGeIe8OZuPQqy/CFcJPeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ML3sUk6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCb2V+O/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8Dw3wd1801835
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 18:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r6FePatGCvy+ETtTkeEM3vn/
	9lE+wgGoRAkcvzm/jgE=; b=ML3sUk6ACc2NmDqhPQ4doplG60TbEkxIuGnrtpwM
	bMd+Y5iSfoc9sw2DaeEjtvwJgjYEVA+7Vvuch2/bfK9NJLzoENfLtE2PNVvUzO0Z
	yDmF7xCVhh0tEzeCq+Ss59uMVFcDF/YjK9VD7JcbVR1czc+WFmNqnv1lrkcQg6TA
	IJ3DEI++iN35i+FJ/E60q+XeivmKITQOh/gOkWhiH8jwsJI9/Yo5TbAkGZTsqHqu
	ID5mcvkK80231t5Y18lPOpa2RoNkVRBa6HvFGTXiV8gJswsYs7kWzOKnPcPyw1Fz
	uH1m1ITMdOrzRo/cMabY0jdpxaj9vHdzSHDrEejHcAMqKg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y1h0yc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 18:11:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eda95d8809so12098301cf.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762625459; x=1763230259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6FePatGCvy+ETtTkeEM3vn/9lE+wgGoRAkcvzm/jgE=;
        b=aCb2V+O/EZQq/YoB3rPa6cnoWLgHERXTyAYPKSgvxoR7BoKBXSDNTVGWI01N1kjlb0
         89hUiXOqIS/XP3CcHsQ6zN09z6ixDFLdLwGhGIBDnhCD9GYUqTqoh/nzHQU7ghL1p9lj
         bfNcDSUQ4TcQ818nc+AenuwO3RjXlJgvEoa9ReBwTUjkkNidsXum8HCZWkU0JCkImAH+
         /sFRVK9+abP85Yi2mTdJYLe7zRKjSCZKmGNjnKZEPojMnGf/6R0iUjHIyaXoyvbXRI1L
         /zPbmxA430Z1f0VoVpsGbn/9J1FHx6166+5ukTNZSkqAAH5tFBBJlIwM15/h+8mOKHcI
         zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625459; x=1763230259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6FePatGCvy+ETtTkeEM3vn/9lE+wgGoRAkcvzm/jgE=;
        b=un0fz71fhMKisYgH7F7BVBIUDpj3KMp3EbpfCBfUaN+rPqjZuJOWbatxsgR1oM3L2S
         aNchaOzp2osqfeIPV8kB+xoaKLZxQdOhAGV5r6ooqPZkxeQlUZ7pLEJs2Ixv3SoyO95k
         ibXCEXtfKqly4xm+lt6A/dRHrsa3mOG/n02BALY05hfwF7DZ6skX7dcI9wCcwAF1KzZ0
         lfHiIsoo7EPeD3VE6ObPTU6pxuA59NpxDFw2uaFNScByuNUGTE/bjOmYzV0GHwyPhVz+
         Lm2R/Kzex+WQc6aFoWFWcMsglcFIMgUkZ7eflEWBhTZNGg1dT1E+cTLsBTuhIBYFLiN3
         71uA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJbKqN5zh4PSQkBrzn+OOUsusGSa31SP99eCzRGspj6X5kfdWzSo32BWfdnIghARsupLuTUbBgoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfB4hImODwkfP+8EBEOq3L4sCOkTEGRZ8adB9LLreoKhI50fp
	v1BkAYMEK6hU1KZxqdp/QGz5JvYK0A75DJMk0TR+SpKE4q6WTTpOP9aVjXdCS5xrOSf0Gg+YW0+
	ZWhWBKUb0lTmbz9IODIYBO+A9uMp0XgDXEL/lzSkGNA2X1XPoclwiVKGkTNgh4c4=
X-Gm-Gg: ASbGncuC2F2z5/F7LOgVEvP2zKc3gzZL0mjfdlMJGpCnLwvMFI8ErrRUAIjElYmK6bE
	j1F7/A6vaoB2bJqitWw/TVrSv7sIUfL12FHFQWA4gJ9HSnTGA1nI6cs652xrIDr518bBYCPGVZg
	pnLsepR+V98hQV00KKoMa1vppRRTPmaPVaOzf2IY7XnxbFJ01Y7ZSVC5iTGneuCFdPi7XKK5zPb
	+WGqdLja5CrCtSlZlTlrc5vbifDwQ32Ledn/u04arJWWc+UCPyYi1jN9yqhZtoe/lrqts8i1rJp
	P8FnYheOGkKk9/8DuOpsKW0ltX8lmigHHKPce0/lBj0H7b+wLhYVV5ZZ9UxD9uEZHKxkAuri5wq
	6N1BJ9qqaqN/7BvG0yfODR0WGZTmC5MvufhK1l/LVGy6C/r49cGOXpRjnMKQVVh+jdA3I2qs443
	wWi97wgszPoe2b
X-Received: by 2002:ac8:7e94:0:b0:4ed:18dd:fd4 with SMTP id d75a77b69052e-4eda4eb97ebmr35129141cf.19.1762625459221;
        Sat, 08 Nov 2025 10:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4i3GOQJbaFJJVYsZ0kR4yNKniHd76KAyDxpBZc6xL37rUmvj2LHwuC7290RKXWl1F0SzPcQ==
X-Received: by 2002:ac8:7e94:0:b0:4ed:18dd:fd4 with SMTP id d75a77b69052e-4eda4eb97ebmr35128891cf.19.1762625458771;
        Sat, 08 Nov 2025 10:10:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bcdsm2342727e87.17.2025.11.08.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:10:56 -0800 (PST)
Date: Sat, 8 Nov 2025 20:10:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <gmwg46c3za5z2ev34mms44gpq3sq7sb4jaozbdn5cejwbejbpo@wwr2j7dkjov4>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: OfOINox36GGqWm9ab3Uif2C71yBXSQmq
X-Proofpoint-GUID: OfOINox36GGqWm9ab3Uif2C71yBXSQmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NyBTYWx0ZWRfX4rY2ZFjY3U8z
 DxrxBS482sQ6zF7Cpk0YJrgrOGkD5+CoFoILL4QBLqoKhmp8l/5yio+onzjAKMBFXuLdxPRHUc+
 1ibM74WngzFqQUNTMJ7SuAjDj2Y6fzRc5pqsX0iUq7FH89Ge0+bJjF6b1l1a0Zm2R01Y72DnVBz
 r7MOxFDsFX9VbNgOGefbqkSczUTLcxuzhWcOvPcR7B4N2PAvU++rS9Dil77P1YohHh1PGKyvqlp
 Ug7WldxenP3ymyEjLhbY6+6rVSI3NPXxDSysbCCX/9zDP/PtnwlS6+OnlN9lstIkgnA2JbwuQYJ
 43jTHiVEuelaWfNiFwREjWWj2LV4f8DSNGnJqL+6pgXaPRFS2j+Xf2gzeWWZFL3+1ESrLyosD68
 W+yH/LKS645BslXtF1ej5UwM27a1eQ==
X-Authority-Analysis: v=2.4 cv=Xuj3+FF9 c=1 sm=1 tr=0 ts=690f87b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=i2rTrvYXNPCTwSvIQ-0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080147

On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMB for debugging and supplementary features. At any point of time, the
> connector can only support either PCIe or SATA as the primary host
> interface.
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
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key M Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> +  host system over PCIe/SATA interfaces. These connectors also offer optional
> +  interfaces like USB, SMB.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-m-connector

Is a generic compatible enough here? Compare this to the USB connectors,
which, in case of an independent USB-B connector controlled/ing GPIOs,
gets additional gpio-usb-b-connector?

> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vio1v8-supply:
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
> +        description: PCIe/SATA interface

Should it be defined as having two endpoints: one for PCIe, one for
SATA?

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB interface
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SMB interface
> +
> +    required:
> +      - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  pedet-gpios:
> +    description: GPIO controlled connection to PEDET signal. This signal is used
> +      by the host systems to determine the communication protocol that the M.2
> +      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
> +    maxItems: 1
> +
> +  led1-gpios:
> +    description: GPIO controlled connection to LED_1# signal. This signal is
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
> +
> +  pwrdis-gpios:
> +    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
> +      This signal is used by the host system to disable power on the M.2 card.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO controlled connection to Power Loss Notification (PLN#)
> +      signal. This signal is use to notify the M.2 card by the host system that
> +      the power loss event is expected to occur. Refer, PCI Express M.2
> +      Specification r4.0, sec 3.2.17.1 for more details.
> +    maxItems: 1
> +
> +  plas3-gpios:
> +    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
> +      signal. This signal is used by the M.2 card to notify the host system, the
> +      status of the M.2 card's preparation for power loss.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key M connector for SSDs with PCIe interface
> +  - |
> +    connector {
> +        compatible = "pcie-m2-m-connector";
> +        vpcie3v3-supply = <&vreg_nvme>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pcie6_port0_ep>;
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

