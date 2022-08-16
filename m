Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063B5961DC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiHPSFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiHPSEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 14:04:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9882FB1
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:04:49 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-333b049f231so60282287b3.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0w+kmT2IbUXrv0eEHZ7FURm/G1X4f15u8QTqDUvP+zs=;
        b=H+4Fp77UiZPJN22tx2zuSYct+ZUgUX/7KRVbTNfke0uF6CNy93XZ8gt30706iFh0VT
         aCongEVTuK5iXpZgQYKMZFGYmue0cCWVo2JMCM7dd2B0JMuKeunwa3LCXe8sljOBbbSL
         u4nGojyki+E9M4mN0W+jJWzRkX5aq4ghPhh9ytmtiSSFl/2kQ0ZgO8Rz4idq9YY5Cjs0
         CyRMu9a3SgdsV6qHvYP72SORdEPcSkvqpN7xDj1HHYMpL7jL5rqRmEojLHzQ18G3pDlK
         EUDo54AhME2R07o+vSqqBH2BLBYxSjimNBffmG6IuNz37v5HKEtTyoOWkpRoC5EyDtYW
         Lh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0w+kmT2IbUXrv0eEHZ7FURm/G1X4f15u8QTqDUvP+zs=;
        b=hVXpj8QWpI9WBwbn3agjo03rWE5y2Jruwl0Xngrmlyf0NpWrs3Sjnkxau7+nVSWiOQ
         5Kc/Z1VZRGJz1C2nTytl9zWGsSVnEJfL3nEAoB+dkkt/I04LnacskzM9SE6GAQ8GvfcR
         RKVQn9qI1F8diP59OEW00N4dqeoFZk4hs27go64/drcpp3TRgykDHJABcG/J0052jN9W
         b8bgZwVPyY11mOi8TQBk5lz0yQSI+4R5mo+KKHrFOCNTwkM6LmfYalrTVw3/0iP6cRwv
         YMaP78QVOap9kldPFmVbiZbxpiC8709+j/KQjPrQYXc5QdVlSfVhiuBcpnOFAnaRxTBQ
         alhQ==
X-Gm-Message-State: ACgBeo1CezXHHupr6ThEQQ7v3FNobt0Z1iEk4JHr/6kcY9v0+WXZnlpb
        oU4G3w2QAElV/cO2YLdlS1s3qhShbGp/Ip6peBZV0g==
X-Google-Smtp-Source: AA6agR79SF4EVFLJlu516gzZNXQSrzpATfClnQlDyUuKj1440u+ghdhgDcnBveRRMmlbFyLXqFF1Wsq0FWdZ5y0SreE=
X-Received: by 2002:a81:1793:0:b0:31f:4989:20ce with SMTP id
 141-20020a811793000000b0031f498920cemr18517758ywx.80.1660673088222; Tue, 16
 Aug 2022 11:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <62eed399.170a0220.2503a.1c64@mx.google.com> <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc> <YvEEidOZ62igUYrR@sirena.org.uk>
 <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
 <YvvTKkR4sOIsFxA4@sirena.org.uk> <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
 <YvvZsPcUPND6ZC9e@sirena.org.uk>
In-Reply-To: <YvvZsPcUPND6ZC9e@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Aug 2022 11:04:12 -0700
Message-ID: <CAGETcx9pFtiQy43wV+vbK84P=SbbGcvy6cg9VHg2OzfYHT5n3A@mail.gmail.com>
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on kontron-pitx-imx8m
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 10:54 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 16, 2022 at 10:48:04AM -0700, Saravana Kannan wrote:
> > On Tue, Aug 16, 2022 at 10:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> > (though
> > > TBH given how entirely virtual this stuff us it seems odd that we'd be
> > > going for a bus).
>
> > I'm going for a bus because class doesn't have a distinction between
> > "device has been added" and "device is ready if these things happen".
> > There's nothing to say that a "bus" has to be a real hardware bus.
>
> Sure, but then there's the push to stop using platform devices for
> virtual devices - this feels similar.

That's why we wouldn't be using the platform bus :) I was suggesting
changing regulator_class to regulator_bus and being able to delete
some of the regulator core code because device links would take care
of the same functionality. But this is just improving maintenance so
maybe I should focus more on the feature TODOs first :)

-Saravana
