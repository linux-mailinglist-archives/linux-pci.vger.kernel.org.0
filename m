Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25064FE007
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351625AbiDLMGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352945AbiDLMDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 08:03:45 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0BB6D
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 04:02:20 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so13128424otq.13
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lPRWk7tYMmsDRfb6L0cIPhk87aHWKIzFdUKqjCBpecw=;
        b=AitHsI+5i0JWltdHwAVIdjeQbX+BFut1m5epdjQKJdX8OAtZ1VYPSWZ0WrtAiqyh+4
         ocQsC8FyqsyhXLoZGTNeuMFOrhz7aC+hKyyxHkK8Jcy4+2RWneqQgS4aeRHXmCTkilP6
         EyXBB6K7N0dDJReES4iCMvZGFzun3C1khB/P2UQZlLPGOzyKmMQlA3EYw5/nnxksRey1
         xPLHeRcv1okDgP0JZTTGq4PRaK/rPWgPJzxDZXDAKi0z8GyzONfh9vkMgmrL/ZXLdFE6
         /EH1OqCKJgF+8k1Rmy4DPw+apicwhSv36OlbXOVRpDEGYrgUFpsPSqSih5sTkemcTGig
         3r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lPRWk7tYMmsDRfb6L0cIPhk87aHWKIzFdUKqjCBpecw=;
        b=wYvfPp5srVT1f6zx31XuQ8TIxfbqKnXPKe/d7NTnvyW0kuGbMt+o4d/3IxFM3RGSVa
         nRqnUs3z8is9pdFsgkPjw6n77P7g46TQOGA9BJJVhYSU4XrtWzutBseKya9D0xUiCCDW
         MCnh8Ga+Xy8JoPJ4Y0Asn+wfh7qZitN1wiOhrgJzS8qXNchqIzFY8q29cOWRPjRJm592
         Oe3l05FVrU1jJW5zaWiaRWeKx7ykWbcucaP9a02k8nl1J/z2C2IFFcs4dW8pYXfZaeJd
         5tPS9bqUn4UrG7p7/Cm9mmzhlMm33G8ZRiNpUHlr6zTSPYOq0FCmCngjqlJ7bMplKUfA
         ddKA==
X-Gm-Message-State: AOAM531AgujSTh5dErdZL0VJMHYmTBwQGmfkpEe7DbEdNM1Tnyctg/nO
        shAExfSKZuTkumkKMTiBHiSGWQ==
X-Google-Smtp-Source: ABdhPJzSrqkT3+ljx1cMKHofmHVK5RZZ+gynAz/Nk57j/xkhBwMKzh9z2OIFmmaLTWHqIt78gWqTLQ==
X-Received: by 2002:a05:6830:442a:b0:5c9:3a6b:de3e with SMTP id q42-20020a056830442a00b005c93a6bde3emr13312265otv.151.1649761339569;
        Tue, 12 Apr 2022 04:02:19 -0700 (PDT)
Received: from fedora ([187.64.132.161])
        by smtp.gmail.com with ESMTPSA id y67-20020a4a4546000000b0032476e1cb40sm12552383ooa.25.2022.04.12.04.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:02:18 -0700 (PDT)
Date:   Tue, 12 Apr 2022 08:02:10 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        hongxing.zhu@nxp.com, robh@kernel.org, bhelgaas@google.com,
        helgaas@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YlVcMlaZB00gg0nX@fedora>
References: <YYCOTx68LXu1Tn1i@fedora>
 <YlBFa46v5NtWxGLt@lpieralisi>
 <YlBKyBtbxMpvauLv@fedora>
 <20220411115926.GA20890@francesco-nb.int.toradex.com>
 <c8d3ed7196d09f5f6a61d605a94613f792ab501b.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8d3ed7196d09f5f6a61d605a94613f792ab501b.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/11, Lucas Stach wrote:
> Hi Maíra, hi Lorenzo,
> 
> Am Montag, dem 11.04.2022 um 13:59 +0200 schrieb Francesco Dolcini:
> > On Fri, Apr 08, 2022 at 11:46:32AM -0300, Maíra Canal wrote:
> > > On Fri, Apr 08, 2022 at 03:23:39PM +0100, Lorenzo Pieralisi wrote:
> > > > On Mon, Nov 01, 2021 at 10:03:11PM -0300, Maíra Canal wrote:
> > > > > Considering the current transition of the GPIO subsystem, remove all
> > > > > dependencies of the legacy GPIO interface (linux/gpio.h and linux
> > > > > /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> > > > > 
> > > > > Signed-off-by: Maíra Canal <maira.canal@usp.br>
> > > > > ---
> > > > > V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> > > > > V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
> > > > >  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> ... they do conflict and I guess the functional fix for the reset
> sequence should have priority over this cleanup. Maíra, may I ask you
> to respin your patch as soon as Francescos fix is in? I promise to not
> let it fall through the cracks again.

Hi Lucas

That's fine. After Francescos patch is applied, I resend the fix.

Thank you for the feedback!

Sincerly,
Maíra Canal

> 
> Regards,
> Lucas
> 
