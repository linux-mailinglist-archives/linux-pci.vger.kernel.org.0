Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80017CD973
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJRKmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjJRKmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 06:42:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73C595;
        Wed, 18 Oct 2023 03:42:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5056059e0so77576241fa.3;
        Wed, 18 Oct 2023 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697625727; x=1698230527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiN0YIQNx/rIeZobowtqHdBnsSAAP4uKtrmkRfiubgs=;
        b=SVOYMyvoG1WWBUnC/zNxZbl3F8rhq5WcYfqzm3+c6ozEIUQe1dM40IlMtrJwyIagtf
         i9D2tIzyLqg5F4USjIwg9h3SVWxS6ddE37mR4+DxNB/CLPIcBEz1TOEmmrwiUIQuwYUB
         RFgUXnikCfemXXd/OqxjXhquNEV9uI3dnuIUOQjL0Kv2i+UCaIls6wThKVF33xGU97J4
         BxXAPjyEe8swD/rMCe7+Jfj9oZkDiE5aOm8SRDzeMl25Fsci0wBB9BaPVzfQc0Tm23LU
         qUDjqvMUzIMHj2orIrlJl31pf2P8bxy7fqw6ujDdxABNI1CcUAwuktOVPUlBFe3usMXJ
         RIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625727; x=1698230527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiN0YIQNx/rIeZobowtqHdBnsSAAP4uKtrmkRfiubgs=;
        b=eXIX2Y3RUGLsv/FyMOWrETGKN8wlwkmTxzbiFo27BoZG2+GB+cWMRrwM8D+Xd6HwJ2
         MOoq7EwTymTajwXFrJFxoKuw5WXila7XtMmFDv2l9T+ISrKFr3tSIue8w5CEEKHR7EuL
         Vgr6TayPLSXCkNIkN3p5fzJ1I8ynnJwkpV2EIrrddMhYGqUUbvdZxBiFEZ1AsfJZGdwH
         3TyOwm0iwuv01M9fiXz7he0bEA5XnH6qCWv7HLml7afUGaWaix8XxKDyFkdipCSejBRO
         kXh4DdV+yM4zs87azuCAn07qCnnI2t87OX3vHB5BT6ovuzRpoogebv3/qgoy8pS7Cox0
         9lEw==
X-Gm-Message-State: AOJu0YylcqVBArXo58zoxjWoFHl+nUXyORFAtbG1CmRS/fcOfyCZZ1Zj
        a7k/94Qam7nRGmNz7Ljby+c=
X-Google-Smtp-Source: AGHT+IHUisEIGfw4keE2MaS//SggcghSkMhtEUnGvjfBbNBGDnD3S1PQtgWBwY5GLSZRtL8zoNGtKQ==
X-Received: by 2002:a05:651c:1070:b0:2c5:3322:c2d6 with SMTP id y16-20020a05651c107000b002c53322c2d6mr3027551ljm.7.1697625726544;
        Wed, 18 Oct 2023 03:42:06 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a12-20020a2ebe8c000000b002c27cd20711sm642320ljr.3.2023.10.18.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:42:06 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:42:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Message-ID: <tlx5ysa4jnqzmhq5dpk5yk6uuddpwl5h2ieg6n2h3ozksqyx44@yx5mhvwg5miv>
References: <20231013184958.GA1118393@bhelgaas>
 <c11f4b9f-8cbe-1fd0-886b-f36547dc8d3c@ti.com>
 <klxzte53bzk774zinhfrdwdwalvv2hlvc2mqiuyecxcneqkdbt@qbkyc4fdlcka>
 <eacc8aa9-7480-f46c-8852-88f1f8f46bff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacc8aa9-7480-f46c-8852-88f1f8f46bff@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 09:44:51AM +0530, Siddharth Vadapalli wrote:
> Hello,
> 
> On 17/10/23 02:59, Serge Semin wrote:
> > Hi Siddharth
> > 
> 
> ...
> 
> >>>
> >>> I assume MSI-X actually does work for downstream endpoints?  I
> >>> wouldn't think anybody would have bothered with
> >>> ks_pcie_v3_65_add_bus() unless MSI-X works.
> >>
> >> Yes, I think it is supposed to work, but it doesn't seem to be working right now
> >> considering that even with Endpoint device connected, the readl() returns all Fs.
> > 
> > Could you please have look at what DW PCIe IP-core version is utilized
> > in the Keystone PCIe host controller? If it's of v5.x then here is
> 

> The DW PCIe IP-core version is 4.90a.
> 
> > what HW databook says about the BARs initialization: "If you do use a
> > BAR, then you should program it to capture TLPs that are targeted to
> > your local non-application memory space residing on TRGT1, and not for
> > the application on TRGT0 (dbi). The BAR range must be outside of the
> > three Base/Limit regions."
> 
> Yes, it's the same even in the DW PCIe IP-core version 4.90a Databook:
> 
> 3.5.7.2 RC Mode
> 
> Two BARs are present but are not expected to be used. You should disable them or
> else they will be unnecessarily assigned memory during device enumeration. If
> you do use a BAR, then you should program it to capture TLPs that are targeted
> to your local non-application memory space residing on TRGT1, and not for the
> application on TRGT1. The BAR range must be outside of the three Base/Limit regions.

Are you really sure that it's 4.90a? Here is what my DW PCIe RC
_v4.90_ HW databook says about the BARs:

"Base Address Registers (Offset: 0x10-x14) The Synopsys core does not
implement the optional BARs for the RC product. This is based on the
assumption that the RC host probably has registers on some other
internal bus and has knowledge and setup access to these registers
already."

What you cited resides in the _v5.x_ databooks. It makes my thinking
that in your case the IP-core isn't of 4.90a version.

-Serge(y)

> 
> > 
> > I have no idea whether the BAR being set with an address within the
> > Base/Limit regions could have caused the lags you see, but I would
> > have at least checked that.
> 
> I will check that. Thank you for sharing your feedback.
> 
> > 
> > -Serge(y)
> > 
> >>
> >> -- 
> >> Regards,
> >> Siddharth.
> 
> -- 
> Regards,
> Siddharth.
