Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052364FE7D
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 11:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiLRKl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 05:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiLRKl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 05:41:26 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD404CFC;
        Sun, 18 Dec 2022 02:41:25 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso6414041pjh.1;
        Sun, 18 Dec 2022 02:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWhSManBI4je4nMxJMM4ZaSPOEOq6LDDo1RylzkNEqQ=;
        b=7Cwbeq11ZQeA9qovUP2Xg+slFu+jtJmNCl6nIIo/58yvtjGhjmp3qx19HrX+Ibz369
         sd4u+m8vJtEHyWKlf5RnEmGVFZKH91Rbh+8x2Y5V6r4Lj/Do2GExOtFuRjN2a8k729x9
         c5fnJbnEb3THWDDgtO7sFyk31qxHcGsanI/cyfncZhMW5jcnNMHTl6clseVd9wH6Et3a
         F6IMNHvL+/k4dMhfIUtgVulpR/6RHB0D6mu8sagyHMbAN0xRkzk3mWxNGKez0gWH3IFk
         h2onlIcRjn1A37aYrFx+9cjMWGiAoZd2gZ3JuZjFmhcVaP+B48gNLIKhtbtHteGu2f+p
         ngEQ==
X-Gm-Message-State: ANoB5pmCYb6f2uymyEGI7i+cfr5r/xcckZfD19zEE9KxmQ14Z3DiISdn
        nUqRySl9pL7AM4M6v8uubvs=
X-Google-Smtp-Source: AA0mqf5WO/7Cijtn5yQNAZZB8BrGz8AsTdLX2xUNi50p8THnp+UgPHQu+gm30xlzQSkYGxl6fclYfw==
X-Received: by 2002:a17:902:a588:b0:185:441e:90b5 with SMTP id az8-20020a170902a58800b00185441e90b5mr38289081plb.27.1671360085146;
        Sun, 18 Dec 2022 02:41:25 -0800 (PST)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b00189548573a2sm4815698plw.161.2022.12.18.02.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:41:24 -0800 (PST)
Date:   Sun, 18 Dec 2022 19:41:21 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: dynamic MSIX submission plans
Message-ID: <Y57uUaSWXkSxZzHy@rocinante>
References: <DM8PR12MB5400783BA8E864AC3DA47BD0ABE49@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400783BA8E864AC3DA47BD0ABE49@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Eli,

> With reference to this work
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
> 
> Can you share your plans with respect to submission?
> 
> Are you going to send them for the next kernel?

I assume this was intended to be a private conversation?

	Krzysztof
