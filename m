Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9046DDC18
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDKNcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKNcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 09:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A32135;
        Tue, 11 Apr 2023 06:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C22961F74;
        Tue, 11 Apr 2023 13:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CBC433EF;
        Tue, 11 Apr 2023 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681219928;
        bh=Qy/rBc6YUbkvkDPHSRKGpIkNfKxq2ZbKY7o9v2IVhz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D45cB64+Za0ToL5Ty6Am/itkbcW3HQRXJuxy+3a2UIZh8IA+RVyANUvVZzdfU3sxk
         w1o5jJP0YtTxBKVIcZrDWavfI4P6Gx6Mxx3f8PBprdGtCk5mU47eX+Z20F6jm4ByDt
         jmB4CBIZv8Pj71Q8H0LDfwv/s2q9s3PifJ2OwzigyJt7DeZmpjprWGSv6K2zeJuvOd
         OxdbvQw8KNYad/W9xVsg4iWGjdBRSc53djXYowfizz8MsQtpQCVdnOvEIQWdL3EbiM
         duzW1qObQSdZzTTx0/J7ZN9hCTuE3Xcwox7poSubNQqggiUS5HdJEkCgOoojkh2e+h
         YvYHaSG7dOJuw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmE6P-0003rd-DQ; Tue, 11 Apr 2023 15:32:06 +0200
Date:   Tue, 11 Apr 2023 15:32:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Fix unit address of example root port
Message-ID: <ZDVhVYZ838ksVMYP@hovoldconsulting.com>
References: <20230317112019.9090-1-johan+linaro@kernel.org>
 <ZC1ZTHeRqtghwVBB@hovoldconsulting.com>
 <CAL_JsqJrhQA4dbU=bGioonqs6c=mZiGErcT9v9BxiGrNhmY6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJrhQA4dbU=bGioonqs6c=mZiGErcT9v9BxiGrNhmY6-w@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 08:38:29AM -0500, Rob Herring wrote:
> On Wed, Apr 5, 2023 at 6:19 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Mar 17, 2023 at 12:20:19PM +0100, Johan Hovold wrote:
> > > Fix the unit address of the example root port which is identical to the
> > > device number (i.e. 1).
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> >
> > This one hasn't showed up in linux-next yet. Could you pick it up for
> > 6.4, Lorenzo?
> 
> On 2nd thought, I think it's time to just remove this file. The schema
> is just missing some descriptions and 1 property (external-facing).
> I've added all that here[1].

Sounds good to me. Will you send a patch?

> I didn't add the example to the schema because the example here is
> incomplete and won't validate.

Fair enough. Having a decent example in the tree would be helpful, but
hopefully we can get the in-tree DT sources up to par at some point so
that they can serve that purpose.

Johan

> [1] https://github.com/robherring/dt-schema/commit/8445eb010e61496681e2504faf400e9fbc5b1acf
