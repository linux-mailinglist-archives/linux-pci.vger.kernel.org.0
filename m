Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90636D7DDE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbjDENio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjDENin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 09:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826654C28;
        Wed,  5 Apr 2023 06:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2AA62695;
        Wed,  5 Apr 2023 13:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82236C433D2;
        Wed,  5 Apr 2023 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680701921;
        bh=3S8hJcNlwdtjnnJmZPcBN4nKAn1XDM4RXnsVZem6mw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fCxljYxENLPzhc1/Lw6c9FDo43mCqYk2P55ut19RfpNFEXU7YKQrzQRq7/yVHYOGl
         WdtuvPZ2jSJChRtOfUc2FDJ6U9XBC/llE8aco+jZ14ATm/y/vdvfYMagQEJ3YKqH+B
         KYkjNF2y8KZS5oirwegiG8RfcYpo44H1wG9dGdCD674EZq+koymOJejEj+78huvrYW
         rfcgSoph1tuAZUeFh1zh+nurriXVInZiNuq+uY0kZjLuJz18PnjNI0ooJ5IbxwjoMu
         UtcQ6j0C85oZjxiKqT7JvMlQVJ/E3Z0lPweDRxzr0fdTkI6BPHNs4nwNMlK80gjTuA
         qozlBbeHTn8Mw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-544f7c176easo677115587b3.9;
        Wed, 05 Apr 2023 06:38:41 -0700 (PDT)
X-Gm-Message-State: AAQBX9etTOawlWr6dePyqULJv6Evbn4DwgtJz7a1B4+kFaPgmg7G37VN
        q2DqCl1HCbhbUDzq/msVGVYkWXdntelnQ/pbjA==
X-Google-Smtp-Source: AKy350bKjxRIG96o/zz24UUG8PRz4O5JalHzsE1G5TGNqK2Wr95r2i+qUgd7DzyR0yWa+P5epjfVgtnxRt+Yo9YmdY8=
X-Received: by 2002:a81:ac24:0:b0:546:3252:385d with SMTP id
 k36-20020a81ac24000000b005463252385dmr3613702ywh.5.1680701920515; Wed, 05 Apr
 2023 06:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230317112019.9090-1-johan+linaro@kernel.org> <ZC1ZTHeRqtghwVBB@hovoldconsulting.com>
In-Reply-To: <ZC1ZTHeRqtghwVBB@hovoldconsulting.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Apr 2023 08:38:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrhQA4dbU=bGioonqs6c=mZiGErcT9v9BxiGrNhmY6-w@mail.gmail.com>
Message-ID: <CAL_JsqJrhQA4dbU=bGioonqs6c=mZiGErcT9v9BxiGrNhmY6-w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Fix unit address of example root port
To:     Johan Hovold <johan@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 5, 2023 at 6:19=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Fri, Mar 17, 2023 at 12:20:19PM +0100, Johan Hovold wrote:
> > Fix the unit address of the example root port which is identical to the
> > device number (i.e. 1).
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
>
> This one hasn't showed up in linux-next yet. Could you pick it up for
> 6.4, Lorenzo?

On 2nd thought, I think it's time to just remove this file. The schema
is just missing some descriptions and 1 property (external-facing).
I've added all that here[1].

I didn't add the example to the schema because the example here is
incomplete and won't validate.

Rob

[1] https://github.com/robherring/dt-schema/commit/8445eb010e61496681e2504f=
af400e9fbc5b1acf
