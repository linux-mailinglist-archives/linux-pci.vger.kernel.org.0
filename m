Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7F1A7B4D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502266AbgDNMwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730138AbgDNMv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 08:51:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707BC061A0C;
        Tue, 14 Apr 2020 05:51:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a25so14205889wrd.0;
        Tue, 14 Apr 2020 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=INaiMxSFr4KNjl3DpxnWtwrHIDn60Dm1USBtEnWrWrc=;
        b=PDJLx9zi1OI+5VbYzQkd02uKzO1waQSh/zV5F3EvUj4R0lf428LvqkmNSdRd79LqxN
         yh0X6/0sK/jTdSuQbifotYjj3rhQz2aq1vtnVuNxbaP2fDl+wljpd1k8kfAXvU7ERGJf
         eMSnKtacrGcdgQJGOgFdKNPHZJlFU2gPZl9tcACIWKiMEhmBR66bSDNNeFXm+22SYGuo
         lfUmhXZ1J1d9b1G3YyWws1cHO5kNdsjF2swkcOotXYdE4xJtx2vRJxWdnK0yyKplYpSZ
         rt5eDjHEGFa+OX6BnSQ4Oo6BYIR2W/WrYq8wVh1dPt5OvweJz78ZBjx6r6xAJJKS8pw9
         +xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=INaiMxSFr4KNjl3DpxnWtwrHIDn60Dm1USBtEnWrWrc=;
        b=JgCIC4SH1yPLo8Kr4d9mA4L8/dYxrRta1YvyAZdqxJ1NHCqZstRYdZrcQ8v5pL1i20
         Qt/L09bOqfOL7GR1OXB2QIwEVbrVWBbV7b5MxZIMwm+ohCzLFBr1c3RVBle0OVScoIRu
         2FQOGQG8K2xVaEwnaFo14+g2yXV49AvLj46p/2Dr+qcDOLU9AeRYvlOcy1ZIlITrVOWh
         zqUmtlgH8c/w3RWP2p5BMyeUZ1NyMmdGZ1bJKzztR11d2Eow3/piMJcUcwJbJ9VZ4/EZ
         TvlEHirREcEkNvWEXWhVfg3qdmpjcgR8ItQRj6ebNpprm6/9OL4B0yxm4/YOtBFN/Nui
         XQNw==
X-Gm-Message-State: AGi0Pubsg6D/2l386UQwilhO6PB4/qdFUezd84tUdKm5ywzvr5NAayje
        ewJdXIjyZKGhA+BPkgdtsng=
X-Google-Smtp-Source: APiQypLreekvmOTIyJjoRiEofhwIQiv4aipsIMKjDOyMD8hF5sTi0Hn3DIqB4xhgEstTN6UiwtD3pQ==
X-Received: by 2002:adf:e90e:: with SMTP id f14mr24068876wrm.106.1586868716187;
        Tue, 14 Apr 2020 05:51:56 -0700 (PDT)
Received: from AnsuelXPS (host93-255-dynamic.47-79-r.retail.telecomitalia.it. [79.47.255.93])
        by smtp.gmail.com with ESMTPSA id p10sm18476895wrm.6.2020.04.14.05.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:51:55 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Florian Fainelli'" <f.fainelli@gmail.com>,
        <devicetree@vger.kernel.org>
Cc:     "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Richard Zhu'" <hongxing.zhu@nxp.com>,
        "'Fabio Estevam'" <festevam@gmail.com>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-kernel@vger.kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'NXP Linux Team'" <linux-imx@nxp.com>,
        "'Pengutronix Kernel Team'" <kernel@pengutronix.de>,
        <linux-pci@vger.kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Shawn Guo'" <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Lucas Stach'" <l.stach@pengutronix.de>
References: <20200410004738.19668-1-ansuelsmth@gmail.com> <20200410004738.19668-2-ansuelsmth@gmail.com> <26080c25-cda5-cd3f-a906-a09a79cb1922@gmail.com>
In-Reply-To: <26080c25-cda5-cd3f-a906-a09a79cb1922@gmail.com>
Subject: R: [PATCH 1/4] devicetree: bindings: pci: document tx-deempth tx swing and rx-eq property
Date:   Tue, 14 Apr 2020 14:51:51 +0200
Message-ID: <01ea01d6125b$79590790$6c0b16b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQJxOzeYiZkD8UITQ1/aTwnouqE5vALuml4iApJiW/inFjd00A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On 4/9/2020 5:47 PM, Ansuel Smith wrote:
> > Document tx-deempth, tx swing and rx-eq property property used on
> some
> > device (qcom ipq806x or imx6q) to tune and fix init error of the pci
> > bridge.
> 
> Those properties are not specific to the host bridge per-se, but to the
> PCIe PHY, therefore, one would expect to find those properties within
> the PCIe PHY node if it exists. Given you want this binding to be
> generic, this is an important thing to correct here.
> --
> Florian

So where should I put these? If I understand this properly I should move 
this to the PHY directory but no PCIe PHY node exist for both imx6q 
and ipq806x. How I should proceed? 
It would be better to just drop this and add qcom specific binding to the
driver? 

