Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBED696DAE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 20:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjBNTRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 14:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBNTRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 14:17:37 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1FA265BD;
        Tue, 14 Feb 2023 11:17:36 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s17so13805997ois.10;
        Tue, 14 Feb 2023 11:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBiuz+SQFFy7EarOUH8jPMtqn/udQfeZ8u8wFfmsPVM=;
        b=gSWgfwFdELnEw7bQsfNPAk3P8pQ9MnQjov0eUaTgD2mMlAlSswZapwncQy1J+Jv4z9
         DGrvj9vKvutSSCM9OSyT62dCSqWbgaaRtlokpFF/lC7z0s3QZg0QQwSBhQOy1hlJIFz3
         KRiZumcbKRZ3X6b8E7tyOFuzWZLOrTv/VNsM+PtFOemHVdw9gKigksxyn8FkZXUk1WEz
         9OAyjybqhmr/Qu2bpq9cwfU+NKnHIKNYQywJRdimSQbQHkhzdl4hJig4ktOwVN5FoDcY
         CRDRrvT9Hz2WZsekAcpmOa8YGVfI8dtMXe+2YQ2jqFk8L9PK0F3JxVDrvpAqXd8groce
         81Gg==
X-Gm-Message-State: AO0yUKUOmKRtqGClhRBR1MZMwrAgGK0xi7OG8jgJ8CpZ5HZtSSu2gm3V
        BGMSiU/4SUtHpbQtwxza/w==
X-Google-Smtp-Source: AK7set+b/crO2+7WEplkyi1t0w5Ow224TFItHaiR6M4GdAoGOXaK41xu+4QCl0q9hxEbhrgIJuyluw==
X-Received: by 2002:a05:6808:8c8:b0:37a:f9a1:5cfa with SMTP id k8-20020a05680808c800b0037af9a15cfamr1798718oij.58.1676402256107;
        Tue, 14 Feb 2023 11:17:36 -0800 (PST)
Received: from robh_at_kernel.org (c-67-162-147-231.hsd1.co.comcast.net. [67.162.147.231])
        by smtp.gmail.com with ESMTPSA id o127-20020acabe85000000b0035c21f1a570sm1253373oif.6.2023.02.14.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:17:35 -0800 (PST)
Received: (nullmailer pid 26358 invoked by uid 1000);
        Tue, 14 Feb 2023 19:17:34 -0000
Date:   Tue, 14 Feb 2023 13:17:34 -0600
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
Subject: Re: [PATCH 10/16] dt-bindings: PCI: Add phy-names as required
 property
Message-ID: <20230214191734.GA23567-robh@kernel.org>
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1@epcas5p1.samsung.com>
 <20230214121333.1837-11-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214121333.1837-11-shradha.t@samsung.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 05:43:27PM +0530, Shradha Todi wrote:
> To replace devm_of_phy_get with devm_phy_get to get the
> PHY pointer using non DT version, we need to add phy-names
> property in DT and make it a required property with const
> value.

Also an ABI break.

And unnecessary. You don't need a name with a single entry. Pretty sure 
I fixed that for phy_get at some point.

Rob
