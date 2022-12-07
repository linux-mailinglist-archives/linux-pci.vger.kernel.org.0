Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF264614D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 19:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLGSzN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 13:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGSzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 13:55:11 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E152896;
        Wed,  7 Dec 2022 10:55:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 142so1750256pga.1;
        Wed, 07 Dec 2022 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZcyW1gd3zg4fd9wHjyZaKoHe7UQlx2iwBj5+r5lwtoU=;
        b=QUYI+oBTvrXmif/gn+JK3lOrFCtECQCbbzhdV5P9nIiQrTffTetrNFxzscEawuo32S
         +FbyYmsgy5evvxBDw/NyInajDVWFJwDBLdQZRrqqgntVJvS744l8Xmc64R2Vn/fWYMml
         mrnEbpGDv4sCQ/r9EwB+uUhe8y4zd6RZsfuaRmEf3ZC6mlNqlh6dgZANRfzsncYi+/35
         c6UF7Ofz/TOc7Aw+L/sp5h+6cvs7CikSn8k+gLuhLT12yFWlNRQbifkpwxzFh+Jq15KE
         CIfz5ZWM27H+q6dRMK+ST982qSh0MB6pWdBZF6SmuEmC/gS6IzKRwigG5jz0DEODxT+z
         ZY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcyW1gd3zg4fd9wHjyZaKoHe7UQlx2iwBj5+r5lwtoU=;
        b=Q1vwQ8NS0fgZmsOegF10N/Rkmlp1Uw64OaIegiPddHK42QipeTieAMDWq4uaBJn7h2
         p9PnLWtChotxkV5HQCT3Uj8Rk22hCig1M30xzFa+HIVR5hXHIkMWRfSRLOi9GP/A4tCY
         uTF9xYG9NNN93JfWKlMrylYXIA5MuC4R9eoPiSq0jOf11DFbPCNAcGzbt/qlw4IqtBYs
         vtKFUyVv3XxTdkk3H0nBl/kJgiSswaLwEJpsITlC8DDTKKvWaswggBm0G4ZeYFqI+ywB
         HNqDyHL9FhBcDLDMrnuLlCY1uRjPpyhvHmPVbk/3nmqxXl3xlM9zn0WW85L1FLaF2YDV
         vzJg==
X-Gm-Message-State: ANoB5pkzUTKkP0bQZpDMJ08iIil6HWNH9/RH11PSNzU7VxQ1C6AdPjU7
        EXzvUxsOljz1ArUFneY9Y04=
X-Google-Smtp-Source: AA0mqf6ZDvsKc2bPJvQKql7dHejEDkB0r2kwSBRHdYITJRC3S9CSGASRGhU+id+dPBTkKXHi4G0rUA==
X-Received: by 2002:a05:6a00:1696:b0:537:b0c3:691 with SMTP id k22-20020a056a00169600b00537b0c30691mr75112012pfc.59.1670439310252;
        Wed, 07 Dec 2022 10:55:10 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a61:38c7:d37a:7f43])
        by smtp.gmail.com with ESMTPSA id g23-20020aa796b7000000b00575d1ba0ecfsm5634837pfk.133.2022.12.07.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 10:55:09 -0800 (PST)
Date:   Wed, 7 Dec 2022 10:55:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <Y5DhigXLHMZPhI/E@google.com>
References: <Y3KMEZFv6dpxA+Gv@google.com>
 <20221207143351.GA1439513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207143351.GA1439513@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 08:33:51AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 14, 2022 at 10:42:25AM -0800, Dmitry Torokhov wrote:
> > Switch the driver to the generic version of gpiod API (and away from
> > OF-specific variant), so that we can stop exporting
> > devm_gpiod_get_from_of_node().
> > 
> > Acked-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> This is unrelated to other pending aardvark changes and will help
> unblock the API removal, so I applied this to pci/ctrl/aardvark for
> v6.2, thanks!

Thank you Bjorn!

I wonder if you could also consider picking up the mvebu patch:

	https://lore.kernel.org/all/Y3KbhIi4ZsSO7+Cl@google.com/

pci-mvebu.c is the very last user of of_get_named_gpio_flags() in the
next tree, which we also want to stop exporting.

Thanks.

-- 
Dmitry
