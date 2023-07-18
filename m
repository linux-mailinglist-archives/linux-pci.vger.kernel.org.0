Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7308F757AE9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 13:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGRLvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGRLvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 07:51:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50302B3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 04:51:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5618645b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681061; x=1692273061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHTRQRfWA1hVj1naqWuvPL6l90v/Sy2BCOQ+kw5w3uE=;
        b=CaiKxlH/fjpbWTvok8KCFJspORdG2+SizqtfUdBFX9MVeY2v6GcfPH3WR9ggz0T64q
         owqZEsH/sTMKDC889Syuxe5vfAj1Fvwzgbv05U1y0gaoa/YMMHTW3Em2tAP4/1wY6i3k
         CWsGAxZkoEEgEquqeWXzb25fsyA07RNHco/U8BxsiRoLqHDnHX7IE04La9CrrbXrZU/j
         9NW0jbYcm2hf6h3WvtKfZbNgVvNzFmuRmy0GDW7o5SjnLiI14CnjlWkvxaXhUtWMdii6
         gUXsMg5V2x8J5hlZ7X0Bsw43ljBU4hnjrzNkTo3El1FySQmBOXS79Es+qzYLlTDECY8X
         aU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681061; x=1692273061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHTRQRfWA1hVj1naqWuvPL6l90v/Sy2BCOQ+kw5w3uE=;
        b=G+WNwNWU9g+7A23Rrg3S06MXMQGRDnrqPtl/sCQ+4JaVE1ItjgcNZK+zMM+bQ/cb9y
         2dqgVbHOjdQVST83zcDaM1RxYTM16mxRwVKxqYLd8WlkjQ+8YUD3s+A4G6GSVh/uqZ1l
         /B8m5oQ6VZzLteqQL1YdCabC8tjDhY7MjWa1PsKUR356cIwPEWuxC7gj8ZT8GZmOyMzX
         miuNTINWOEXJA7etm59yDoNS5v2NNoPN/2iE3q8kQhOuIHR5PFeZl5A3U2WZDFAAVL4z
         DFHrmnESx4GGSlPZnyt75i/900J7o/dTZOamoGKm2b1DGgu18hT+Honrvcl5hTcTrQr3
         rtVw==
X-Gm-Message-State: ABy/qLZq0FoCKbU7ZjwIFUl6V7CkqBX/Lh21wjQTG45/ca6zTVJdAcYG
        +XEUzNV2rleGTAfNH/27txbV
X-Google-Smtp-Source: APBJJlGNW53SZ/tSe2fbRrodTKmAQuYmNEfs3AzX4Vy2tPmjQIQDxGI71ijdXbCsrFMbM4IPbnt9Zg==
X-Received: by 2002:a05:6a20:12d2:b0:134:364d:5cdb with SMTP id v18-20020a056a2012d200b00134364d5cdbmr10899946pzg.25.1689681060742;
        Tue, 18 Jul 2023 04:51:00 -0700 (PDT)
Received: from thinkpad ([117.217.187.33])
        by smtp.gmail.com with ESMTPSA id l76-20020a633e4f000000b005633fd3518dsm944136pga.40.2023.07.18.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:51:00 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:20:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718115052.GD4771@thinkpad>
References: <20230717220317.q7hgtpppvruxiapx@pali>
 <20230718111952.GA475778@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718111952.GA475778@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 06:19:52AM -0500, Bjorn Helgaas wrote:
> [+cc Radu]
> 
> On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> > Hello, I have just one question. What do you want to do with pci-mvebu
> > driver? It is already marked as broken for 3 kernel releases and I do
> > not see any progress from anybody (and you rejected my fixes). How long
> > do you want it to have marked as broken?
> 
> I don't think "depends on BROKEN" necessarily means that we plan to
> remove the driver.  I think it just means that it's currently broken,
> but we hope to fix it eventually.
> 
> I think the problem here is the regular vs chained interrupt handlers,
> right?  Radu has been looking at that recently, too, so maybe we can
> have another go at it.
> 

We (Linaro and Redhat) had a discussion a while ago on this topic and I just got
pointed to Radu's series. So yes, we should instead work on that direction
instead of driver hacks which brings maintainers disagreement.

- Mani

> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
