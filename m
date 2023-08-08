Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CFA774CD6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjHHVSw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbjHHVSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:18:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B09E7;
        Tue,  8 Aug 2023 14:16:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so947183e87.2;
        Tue, 08 Aug 2023 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691529372; x=1692134172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BNjTP5A6iaNI8I0ONshSv2dOVlvAeNExB7nL8frDXM=;
        b=kPJk8NVCa0OhcQbj4ylogCMt7dAfsI9yvrORqoGfysNysjEzWc2ZB+7zHoJsOgAVqe
         oYMcEbr3U93UgOGF/33F1pYatSv/ft5i5CuTJkke34BHbam6cPRIpOkj1C2yeIae0DAq
         y34jpG95/wTF194ZFgzZxzBl82OqkTWP0BmMjoOvGwM9eRqh8WWv8rQpo1udGGHushcP
         1/J30RQD0BO400ObLlpNa+rfGLAUfRP+aQSEWfaP+Ic0CijMa8Y9Z9etx4EM+sdcki9V
         s2/fsAJ1PWpB53TpjptaY41j3f/JUe72riJkmSCyKtR9ivhNQts1wQ6ujmj2T7lIaNZJ
         frgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529372; x=1692134172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BNjTP5A6iaNI8I0ONshSv2dOVlvAeNExB7nL8frDXM=;
        b=EnhES3LjR/1gxAgrTdU2+LD7qgd9CS8u65WJy76Vk+5ORtOVWR5am5UyD+WiLt0m4Y
         k4wmO6qbF6OEFbO9FU0PMcm//xm6NLZ9kTe7+HdGBR/j6ycMS3wSpSIme/2kc5CAvnn3
         yeMp5BdjYclxiiDm9VIzRNvuLamosrBAgPVtig3TVupyFwPTJY4GrVwOdWEyRhjbRWU2
         v+G97SwagNAREUAOfBZwwK+MHX9oXaAXKEY2PRcvMupmpplvlOUcaGwZLIMEob0iulyS
         /aFz59nC0Na4yEn6Zztb0wTes8/F8uCE582EmzFfYnPBoxuAgoBodl+mywWPNnpKpBZ5
         se3A==
X-Gm-Message-State: AOJu0Yxuoc3xrT9GSVOmGm7ljfc+86zW6HBvw61m67gT7Au3Wg8mipKy
        Y4zF3a9vtqFyW4UqT/09BnNnv6jbeHk=
X-Google-Smtp-Source: AGHT+IFrbk/VfHFBjLAmGI1jyvpDVk0+ej8DQKimek6J+8iYsTeNTqGCNG+LkpMVasMLcc+YElYUSg==
X-Received: by 2002:a05:6512:3f7:b0:4fb:7b4c:d38c with SMTP id n23-20020a05651203f700b004fb7b4cd38cmr360748lfq.60.1691529371918;
        Tue, 08 Aug 2023 14:16:11 -0700 (PDT)
Received: from mobilestation (89-109-45-41.dynamic.mts-nn.ru. [89.109.45.41])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fe47879d93sm2016304lfc.106.2023.08.08.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:16:11 -0700 (PDT)
Date:   Wed, 9 Aug 2023 00:16:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <rolemxcg3ezjdjkx2y2zbnoxq3zbpvo6cuukhr4lzevwim7pca@xagj3xq54dgg>
References: <rt2vwgmdsxvkb2jh4v6mpnjpfvql44o72nxf663wbnkcvkmift@o2dl5oa435k3>
 <20230808150854.GA304435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808150854.GA304435@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 10:08:54AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 08, 2023 at 03:15:33AM +0300, Serge Semin wrote:
> > On Mon, Aug 07, 2023 at 06:40:34PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Aug 08, 2023 at 01:53:11AM +0300, Serge Semin wrote:
> > > > On Tue, Aug 01, 2023 at 01:50:59AM +0000, Yoshihiro Shimoda wrote:
> > > > > > From: Serge Semin, Sent: Tuesday, August 1, 2023 8:54 AM
> > > > > > On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> > > > > > > To improve code readability, add dw_pcie_link_set_max_link_width().
> > > > > > > ...
> > > 
> > > > > > > @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > > > > >  	val |= PORT_LINK_DLL_LINK_EN;
> > > > > > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > > > > >
> > > > > > > -	if (!pci->num_lanes) {
> > > > > > > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > > > > > > -		return;
> > > > > > > -	}
> > > > > > > -
> > > > > > > -	/* Set the number of lanes */
> > > > > > 
> > > > > > > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > > > > 
> > > > > > My series contains the patch which drops this line:
> > > > > <snip URL>
> > > > > > So either pick my patch up and add it to your series or still pick it up
> > > > > > but with changing the authorship and adding me under the Suggested-by
> > > > > > tag with the email-address I am using to review your series. Bjorn,
> > > > > > what approach would you prefer? Perhaps alternative?
> > 
> > > I don't really see the argument here.  AFAICT, Yoshihiro's patch
> > > (https://lore.kernel.org/r/20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com)
> > > is a trivial refactoring to make dw_pcie_link_set_max_link_width(),
> > > which might be reused elsewhere later, which seems perfectly fine.
> > > 
> > > It'd be fine with me to add a little detail in the commit log to
> > > reference the Synopsys manual, which I don't have.  But doesn't seem
> > > like a big deal to me.
> > 
> > More details are in one of my earlier comments to this patch which
> > Yoshihiro promised to add to the patch log on the next patchset
> > revision. You can read it here:
> > https://lore.kernel.org/linux-pci/20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com/T/#m8ac364249f40c726da88316b67f11a6d55068ef0
> > 
> > > Dropping the PORT_LINK_FAST_LINK_MODE mask seems like a separate
> > > question that should be in a separate patch.
> > > https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
> > > says it's redundant, so it sounds more like a cleanup than a fix.
> > 
> > That's the point of my comment. There is no need in copying that mask
> > to the dw_pcie_link_set_max_link_width() method because first it's
> > unrelated to the link-width setting, second it's redundant. There is
> > my patch dropping the mask with the proper justification:
> > https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
> > It would be good to either merge it in before the Yoshihiro' series or
> > add my patch to the Yoshihiro' patchset. But it's in the patchwork
> > limbo now, neither you nor Lorenzo or Krzysztof were willing to merge
> > it in. That's why I suggested to move the patch here with the denoted
> > alterations. Could you give your resolution whether the suggested
> > movement is ok or perhaps you or Lorenzo or Krzysztof consider merge
> > it in as is?
> 
> If I understand Yoshihiro's patch, it pulls code out into
> dw_pcie_link_set_max_link_width() without changing that code.  That
> seems like the best approach to me because it's very easy to review.
> 

> If we want to remove a little redundant code later in a separate
> patch, that's fine too but doesn't seem urgent.  I don't think they
> need to be tied together.

Well, my point was the opposite: why would we need to maintain a dead,
redundant code which also unrelated to the function it's being copied
to, meanwhile there is already available patch which drops that code
and Yoshihiro needs to resubmit a new revision of his series anyway?
It would have been much better to just merge in my patch/change
somehow (with another authorship if that's the problem) and forget
about that from now on. If you get to merge in the Yoshohiro patchset
first, my patch won't be cleanly applicable after that.

-Serge(y)

> 
> Bjorn
