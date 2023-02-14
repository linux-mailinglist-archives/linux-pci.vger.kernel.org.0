Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2515E696DA3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBNTPU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 14:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBNTPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 14:15:19 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929A25E2B;
        Tue, 14 Feb 2023 11:15:18 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s17so13800985ois.10;
        Tue, 14 Feb 2023 11:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7E1DSdu/LjiowmOkJlnBDIhObd6gc/Np+y6yfsuUDM=;
        b=XyDmGvworGqksLcRUTudP9jtCO64oyA9QLk/+ukbj+cOcIzle0xv1g6feBk/vIsBNA
         Rgpk8a1X0QqCTaFTtPws8yTi86U/4uNyu+Z4hB0QGv6BrnT9OSTdzGYM2q1dLlEcO6Ll
         xlLGuMAM0AARWOe2/Q/yogsAmsdvRYI7tZXg+cu0VOpwCprnUD9mAGetoeV9esf/3a7f
         RpBbUl/jfxaEVgtZycc10wEyt20rZsLpNeFvN7wXpAhTn3DMJxZ2pqpATbusbASnwq+N
         2QzR6DTQjhyFYyx21fkdfn9aAOZmiTig9mE4UoviPZpV4GoDiqQAabMXtyMtqvbgad5s
         uIbg==
X-Gm-Message-State: AO0yUKWiMbCEdkgbOueVvZ85em0JYhfGM6PRI/J07IijhfXHJRfYfmeN
        K4OFO4D66U2sPMtNgzDV5g==
X-Google-Smtp-Source: AK7set/s+ZMpe9dhdBmBZP5DzD386ZNtV5w8oBNaH00NPOjMkEe1Rab3IGnhmsWphHoipV10bWxlOg==
X-Received: by 2002:a05:6808:a8b:b0:364:5b57:363d with SMTP id q11-20020a0568080a8b00b003645b57363dmr1460638oij.59.1676402118080;
        Tue, 14 Feb 2023 11:15:18 -0800 (PST)
Received: from robh_at_kernel.org (c-67-162-147-231.hsd1.co.comcast.net. [67.162.147.231])
        by smtp.gmail.com with ESMTPSA id p125-20020acad883000000b003436fa2c23bsm6529285oig.7.2023.02.14.11.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:15:17 -0800 (PST)
Received: (nullmailer pid 23333 invoked by uid 1000);
        Tue, 14 Feb 2023 19:15:16 -0000
Date:   Tue, 14 Feb 2023 13:15:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] dt-bindings: PCI: Rename the term elbi to appl
Message-ID: <20230214191516.GA17421-robh@kernel.org>
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499@epcas5p3.samsung.com>
 <20230214121333.1837-6-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214121333.1837-6-shradha.t@samsung.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 05:43:22PM +0530, Shradha Todi wrote:
> DT uses the name elbi in reg-names for application logic
> registers which is a wrong nomenclature. This patch fixes
> the same.
> 
> This commit shouldn't be applied without changes
> "arm64: dts: Rename the term elbi to appl" and
> "PCI: samsung: Rename the term elbi to appl"

Which is your clue that this is an ABI break. You're stuck with the old 
name unless the ABI break is fine for all Samsung platforms using this.

Rob
