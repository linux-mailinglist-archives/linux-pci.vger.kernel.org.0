Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C976CB17
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 12:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjHBKjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjHBKjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 06:39:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08723591
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 03:36:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbbbb77b38so39838745ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Aug 2023 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690972574; x=1691577374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6SoYBxM++sQRnEvr88ExVaXxBGkqpVaUtkVISYvTFsI=;
        b=M8gvfBCvPNLGg8XfKBdUfrQ6KoikV7WwWZDScW47fSTtHFkp/a8FQin/toZt+BS8Su
         OyYm4UEXabyqY4ck2EERihBFlawirCO0Tmw8hXXxZFD5vle2XPkOKyTWV8ICF/R8U22s
         55s0CjwzAvNsfg9MkE3wk1HRsPcbQh9gMTgySJTFzrauScf3ygzGYFt6UwsaBCnJ6kbf
         uOnwphRw6wvRj35hgpSnbDSqaEReS/Zm9OgMb8Mrivp42J/LUnPrxGif1dY32jbnqc71
         6hhq4D5UrNV+KTFTkQrvKqZMtPXDci3NYw8Jf4v2FChp2jx0i6jwTn8psX1KJ2LsbRWA
         80eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690972574; x=1691577374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SoYBxM++sQRnEvr88ExVaXxBGkqpVaUtkVISYvTFsI=;
        b=Y2EYw9gkuCQMhYpLkPtr0O1SEf1QQtjn7tfSAyIdJ1CrPgi84kxIVW6YgFm+ofkfYQ
         +0bjQ2gqG6QLHTW0zrD9GMffnmBQ9WxmgGQ//QF9CFYzxMo/FgdNpsXACBTpb4Du4/EV
         fqXpra3YNBPZ1qxo+FMZ54qpR6mc5byrLzyWvzDQxekKcVxa6oeTJ67Z3ybMh4tNKQw/
         LqHAr0N9owZfTYjqxPiQDHf93AqWj0rwab1QPSPDcvEFW+2RA7XcdrGWWE654Ci3K0UB
         WGGMnNx6ey8lam0P9cIcyxckPxotO2YQ5yge/J+QshN/kKLtTRfdYknBmZjrFCJ472zM
         5nfw==
X-Gm-Message-State: ABy/qLYHLby67l4pwHm4vy9snSxzjxua33YRPtu8Pjcp8wSRUdveOeCr
        jkGXA+LbwRtU48lxk/LBVDtf
X-Google-Smtp-Source: APBJJlHlmtfq2slN0a2zzy0MBXq1feRFQhWqdOKG6s4V/ILLPbhM7BTCLXvolkEKvOoI3v87zK4afw==
X-Received: by 2002:a17:902:dad2:b0:1b9:e9f1:91e0 with SMTP id q18-20020a170902dad200b001b9e9f191e0mr14830408plx.41.1690972574001;
        Wed, 02 Aug 2023 03:36:14 -0700 (PDT)
Received: from thinkpad ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001b9d7c8f44dsm12095919plb.182.2023.08.02.03.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:36:13 -0700 (PDT)
Date:   Wed, 2 Aug 2023 16:06:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230802103605.GA57374@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-18-yoshihiro.shimoda.uh@renesas.com>
 <20230724122820.GM6291@thinkpad>
 <gmy7uzvuy2fkmc7hsanslkv2f4mxzydxvewrv5i5w3b3voqzfv@nmkpewdj726m>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gmy7uzvuy2fkmc7hsanslkv2f4mxzydxvewrv5i5w3b3voqzfv@nmkpewdj726m>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 04:06:32AM +0300, Serge Semin wrote:
> On Mon, Jul 24, 2023 at 05:58:20PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 21, 2023 at 04:44:49PM +0900, Yoshihiro Shimoda wrote:
> > > Add R-Car Gen4 PCIe Host support. This controller is based on
> > > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > > registers so that requires initialization code like mode setting
> > > and retraining and so on.
> > > 
> > > To reduce code delta, adds some helper functions which are used by
> > > both the host driver and the endpoint driver (which is added
> > > immediately afterwards) into a separate file.
> > > 
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig            |   9 +
> > >  drivers/pci/controller/dwc/Makefile           |   2 +
> > >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 149 +++++++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 200 ++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
> > >  5 files changed, 404 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > 

[...]

> > 
> > > +		return err;
> > > +	}
> > > +
> > > +	err = rcar_gen4_pcie_prepare(rcar);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> 
> > > +	err = rcar_gen4_add_dw_pcie_rp(rcar);
> > > +	if (err < 0)
> > > +		goto err_add;
> > > +
> > > +	return 0;
> > > +
> > > +err_add:
> > 
> > err_prepare
> 
> IMO either "err_unprepare" or "err_add_rp". First option seems better
> since unlike the second version it would look correct in case of
> having multiple gotos to the same label.
> 
> "err_prepare" doesn't indicate neither the target code nor the source
> of the jump. So the name doesn't sound descriptive if not to say
> misleading.
> 

I just blindly went with the function name. Yes, "err_unprepare" would be the
correct label name.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
