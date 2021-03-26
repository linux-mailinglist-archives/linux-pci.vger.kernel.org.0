Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5B34A2AB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 08:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCZHqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 03:46:07 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44585 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCZHpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 03:45:45 -0400
Received: by mail-lj1-f169.google.com with SMTP id u9so6270483ljd.11;
        Fri, 26 Mar 2021 00:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywvkB00IvDFZV6YQmhIhOKybvJUh+b6uDebafNOLRY4=;
        b=ZHm+sd8Kbxd3JUe/1xOcABI8A0dq1U0dEgq1g4hyGXJu/TQT7KhAVQ6nBQC7DCqxBe
         EwPmyqpVnjWeLqw4JIxMarTIucQ7LPmwrEeebfQeiTBPgq0qK+PDU8Hm+W62Ax3Ov0S4
         20/tUltPwrhTiNR5V995WHLCFpkJdHLzLypYOsQxYT/6wsUeYZNUIREl+i1iN8x06+I+
         DANoxpIVO1iUxywcKTkDn2YSNZw6NIC4R2ul29iBJ1nr7CEB4p4AA7vpDhrObioPRlIX
         t9btfqx34/7KCv7o52Tfk3LbW0cWxIcR8RF0ja4zuZjPVahFbcuWFiJts3TrNAmmBcLu
         tNEg==
X-Gm-Message-State: AOAM532wpg8loU+g/I6qzgFC3cpWVIpSlOFOsz1jowV7WAW3AA2Uz0Mc
        UgDU6TwCzNijff4ED1653cQ=
X-Google-Smtp-Source: ABdhPJwb3jQF3cra0pp3V4N320JYWJhuowVizCovesrIxUIVKTNdHrrBqTXg/XyD25OMivTB6AbI8g==
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr8167587ljj.465.1616744743808;
        Fri, 26 Mar 2021 00:45:43 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o82sm784730lfa.21.2021.03.26.00.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 00:45:43 -0700 (PDT)
Date:   Fri, 26 Mar 2021 08:45:42 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, bhelgaas@google.com, stefan@agner.ch,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 3/3] PCI: imx: clear vreg bypass when pcie vph voltage
 is 3v3
Message-ID: <YF2RJib3k8RiYF4S@rocinante>
References: <1616661882-26487-1-git-send-email-hongxing.zhu@nxp.com>
 <1616661882-26487-4-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616661882-26487-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> +		/*
> +		 * Regarding to the datasheet, the PCIE_VPH is suggested
> +		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
> +		 * VREG_BYPASS should be cleared to zero.
> +		 */
[...]

A small nitpick here.  What about the following:

	Regarding the data sheet, the PCIE_VPH is suggested to be 1.8V.
	If the PCIE_VPH is supplied with 3.3V, the VREG_BYPASS should be
	cleared to zero.

What do you think?

Krzysztof
