Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CA5988F1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiHRQce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344796AbiHRQcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 12:32:33 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36976CF59;
        Thu, 18 Aug 2022 09:32:32 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id c4so661654iof.3;
        Thu, 18 Aug 2022 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=BgmefGHfNSq1le+mHfAfzq3gcacHjAI6qbIlu87XEfY=;
        b=hAbcMkRXJdu6k7RU8jo6cexIEdOoB042c0gORAecbMqtXOsjQMqMlHDuPiasJSj3nC
         Sjq+yzlO87tTCT/XcI/4qNIX+kpIj/fGuBOoPYkIMtbSGMIyHJO65Vz4PguAGNqnz++y
         aZie8ULPpVzRdsXarCPJU4zXNDPyLDF/2/eP3ksi134VNvRs7nVuLlnZYm9cZrVgMMSm
         z6dvIvDKCCvJT5gEvdMxAiagUmFiKCV5PnLBAGyukBCUnINwCdqJS/CPQ21gPAexBts4
         4LcTh+8RHnHluzT3IdnqUnj8moHOrRD0/g43JWyM8HpnNE0wDK6ZOC/3KLatRKvSB1mb
         pM4w==
X-Gm-Message-State: ACgBeo0+fdGOPvR7lnQsv88TKTv4lcAJhYyaILA0jaeKsZ4k2hZsD5Px
        nyY0zpVGkYTHSVIBp2f1fA==
X-Google-Smtp-Source: AA6agR71fMBrlLxza/+6/LYQ2Qf/v/19ZNs76TujF14zmKhVMzM76/ArJr4ojTVsmMcK66HubfDODg==
X-Received: by 2002:a02:c9cb:0:b0:347:47b:659c with SMTP id c11-20020a02c9cb000000b00347047b659cmr1012124jap.72.1660840351994;
        Thu, 18 Aug 2022 09:32:31 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:647:4ff2:3529:f8cd:d6cd:ac54])
        by smtp.gmail.com with ESMTPSA id b11-20020a92c84b000000b002ddc8e785desm799023ilq.15.2022.08.18.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:32:31 -0700 (PDT)
Received: (nullmailer pid 1990521 invoked by uid 1000);
        Thu, 18 Aug 2022 16:32:27 -0000
Date:   Thu, 18 Aug 2022 10:32:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: PCI: mvebu: Update information about
 error interrupt
Message-ID: <20220818163227.GA1978870-robh@kernel.org>
References: <20220817230036.817-1-pali@kernel.org>
 <20220817230036.817-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817230036.817-2-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 01:00:33AM +0200, Pali Rohár wrote:
> mvebu error interrupt is triggered by any non-intx event, which is mainly
> some pcie error.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
