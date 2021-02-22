Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08036321E16
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 18:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBVR3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 12:29:53 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37530 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBVR3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 12:29:53 -0500
Received: by mail-lj1-f174.google.com with SMTP id q14so59876403ljp.4;
        Mon, 22 Feb 2021 09:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmQS7M3u2VmqATtA8JDFLctXoCBqO8GB9D7gSV+4AYo=;
        b=cky2jJlZgeDkvKPAcw+WIMVpwko/DvhwbM+d7h1kj6rlcoa0KVpzFOAJjofBOImdSk
         1M2CXcRUKyIzN1H7iNLUlU4jk3/sebC0IQxflM3ESjo2a1E56EVZ6h9OT441y1DyfG5e
         pntej4+dEw39Vow/lFO3Ix3xC2RfFJy6RYrvyk0Cm5t1HDY/gCAhKJ0MPlk4LaTn/l2N
         iHuqnqkSNNhiSPINgkFBGSo+AoLg3ELBdtZa1Otd+Km/EFPW434P5sLi7iOEkP4aC7UV
         ENoVVLnFNVVBEXbUXIr/JPzDS41Ntie08GA9iNPv1hz9Ici7F3884Q+daPgivT5qHzhR
         CVJw==
X-Gm-Message-State: AOAM533LyOaEEs4CGyFRBYg4dW6tpeWFjD07vFSl5DMvI0cu78dCEYwQ
        vfbgaAgzcUXxYUmTBh+1ax0=
X-Google-Smtp-Source: ABdhPJxM3LU/ep9uq1WAARfclR/xzL43XNvsNnnLPfqVsHa0aQpDCMjLdZihQ2mkcNapivQEnKmDbg==
X-Received: by 2002:a05:651c:1196:: with SMTP id w22mr14971868ljo.42.1614014950856;
        Mon, 22 Feb 2021 09:29:10 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p13sm2257417ljj.49.2021.02.22.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:29:10 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:29:09 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: ti,j721e: Add binding to
 represent refclk to the connector
Message-ID: <YDPp5VS120Cc79ey@rocinante>
References: <20210222114030.26445-1-kishon@ti.com>
 <20210222114030.26445-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222114030.26445-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

[...]
>    clocks:
> -    maxItems: 1
> -    description: clock-specifier to represent input to the PCIe
> +    minItems: 1
> +    maxItems: 2
> +    description: clock-specifier to represent input to the PCIe for 1 item.
> +      2nd item if present represents reference clock to the connector.
[...]

I am not an expert on device trees, but what do you think of making this
description to be as follows:

  description: |+
    clock-specifier to represent input to the PCIe for 1 item.
    2nd item if present represents reference clock to the connector.

What do you think?

Krzysztof
