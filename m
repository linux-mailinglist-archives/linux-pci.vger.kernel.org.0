Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE766FCA42
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjEIPbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPbc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 11:31:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B0644BB;
        Tue,  9 May 2023 08:31:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab15dbef23so883588a34.3;
        Tue, 09 May 2023 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646291; x=1686238291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YRq/aD3id00csyltRjTJ0ftOlEFFMSQYHa31MfuaUnM=;
        b=sgRRFgb7KtKM8zt5Fb3JxnHYjqTMByaeZ/I3aaObqzABZN2saFUvg7jIbTB+CnV0Gp
         PVC92+Wd3PJsKkghOrUB3KZ/UrAjwevOqXkuGXqD0AnVI+1wai1eaIL7s3ZU8tkK+zCq
         Dtlr26Uyb5ch6ytcHzOvIjE3aZkD64b0dsaApgwNrpYok9+A7rAhV/yanySZN1Vkr81r
         vOQMWdfWnxH27IWB22sr0NgK0MLghhNBA//0SHV+6GmNfA9kfJpPfRWaJF0V0CLFBJTd
         5vrvBYvU3Ybyn3qQey2mO4mtrOrHcPO6H2d3lgzze8bJcTOtL5QmWaLlZyWiWZ9a4SP/
         iBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646291; x=1686238291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRq/aD3id00csyltRjTJ0ftOlEFFMSQYHa31MfuaUnM=;
        b=Dil/7+amy5j4M1LqfUCngMFiO1Zxuhh/Pv3CXy9SojHMkQfZ1zYw8dfu1f7m51UUoE
         2NnodoVc0Wyjx+6J6vQZOC5sLlu9r02s71wrOrIbIUGs9JB2IUrkkr5YLRmxWixEezuf
         /Q3RhmoM5KV0o8Tqf8EAcn8g8rHz53PBjBrBO68JFVZBuki6FN9psAZmkqeKgyNxSgjd
         LL7rhafHtzUsW/vfZH/qpBxybu6kFcRWy02unucEi2WQ2YzP2xUd50DtCvVP0QbSq/mV
         R8hZGHeeMalk7bPhRunuwdPAk7KFw+89xk+8n6pg9uDwDwXpxo0DICUG8YsDIjibIUNI
         CA/Q==
X-Gm-Message-State: AC+VfDx7Tyo3IV09eRAkuaxlSArkMWMDJLmh8cIEeLvPaMuweTnQH1MO
        lZ0M7Y2b154n8KMmUCmMmFEb5ksRQp+AOYxyaRM=
X-Google-Smtp-Source: ACHHUZ6JhLfo1J4qdGQamADfqvzqtpmuoC67PYVcnPOQ1MlOnqx2xDS8nZ5Pp1Gl/+rksyc+GLNFx4ITm3r/t77nX9c=
X-Received: by 2002:a9d:6294:0:b0:6ab:1338:fed5 with SMTP id
 x20-20020a9d6294000000b006ab1338fed5mr1612620otk.11.1683646290910; Tue, 09
 May 2023 08:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230427055032.85015-2-rath@ibv-augsburg.de> <20230427183040.GA263395@bhelgaas>
In-Reply-To: <20230427183040.GA263395@bhelgaas>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 9 May 2023 17:31:19 +0200
Message-ID: <CAH9NwWeJMnBTTOk-PG_5U-t5aLFEAWC+or9-FJYKSGbbHoH_YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency properties
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dominic Rath <rath@ibv-augsburg.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

>
> On Thu, Apr 27, 2023 at 07:50:30AM +0200, Dominic Rath wrote:
> > From: Alexander Bahle <bahle@ibv-augsburg.de>
> >
> > Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
> > setting the PCIe PHY latencies.
> > The properties expect a list of uint32 PHY latencies in picoseconds for
> > every supported speed starting at PCIe Gen1, e.g.:
> >
> >   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
> >   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
>
> Are these things that could/should be described in a more generic
> place?  They don't look necessarily Cadence-specific.
>

As there is currently no generic binding, would you like to see a new
yaml binding
added (Documentation/devicetree/bindings/phy/phy.yaml) that contains just the
two phy properties?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
