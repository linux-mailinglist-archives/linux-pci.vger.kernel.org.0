Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F213A4BAC66
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 23:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiBQWNz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 17:13:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbiBQWNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 17:13:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C548163D6E
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:13:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f17so12196967edd.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4plgjiqS2QK8Hmz5yrY4tZIjyf9T2ewbtV9rL2FH4uw=;
        b=X19onoIxU/IfVFC2OCrrUir6LPpgOqM4UQBZrnT6a61FR1qBzD+SQVY4Yl4FeAffIo
         tOzHmnml7Ak8I4fbXcRAYBOUozIGsPkALUpgSqMyDLuZQWUa1MutlrK1cS6wHJPI3f1s
         J9JLQ1xdK7WzFL8bNMyZ5e2PzI2m2ZjeKpC7jVUprltM5H8DACoLGF7CL+8E5RCzcAqd
         63B+DdlmrDkPMPJfLZs+7SrfBbP39lY3EGhHTbFcMX25Dw227syUHxNXwDIT7HioIeIZ
         1+0nJHhUwH/4T6B7I4knLQoA/zYOmqfaOf6T3Q64LlppfXSxEIlnVkx7RiF0R7zbN2Jf
         r/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4plgjiqS2QK8Hmz5yrY4tZIjyf9T2ewbtV9rL2FH4uw=;
        b=AkKQoRwM4b5vgtlOONHxXWYDwSdT/AbLIi1UMEwq62CvwDKU0bArqI/wkXXk9KUIR1
         0NT3jaTA4lc9b8uPYfo+TBXDfdOdqmOnNvzGUTZsCPz5MfonVBVtPgG6vt/h50sPFyXs
         9pVyndCnx2jLuViT+ddv6ZHKYTtZTQQNCYOnUT26W3FBW1LgnaO0yPx6zkXIu7JqwtmY
         1Nlm4CG9FipKRtXGKl1+VleO03vOrHr5M8Qeae8bJDpDaBOopBlZf529hR6OSyHR/Hd2
         dlUHaxgW+RlF2l3yGPqqtpJV6GRwGm4JvKSIpeSW1Cd2z+qgWXWkaESqPjy201d+r6V2
         Im1w==
X-Gm-Message-State: AOAM533r6sNbJcKzFMYxRRo+2ZU5kkpzvERuU61XHf0fZ0FCLQyvtQIj
        YIL7/0Jbv5TULOcF1YB0KAwLC95tYKXpwrjCL/0=
X-Google-Smtp-Source: ABdhPJyH86NIFvhHncvh/IH9kn8yUd13s9yvDDirnv/rjoRHoe/SEs5DDtRtjv5rqlGMQkce9LMyIqW8ygmlfSl0tfY=
X-Received: by 2002:aa7:d999:0:b0:40e:fdf0:38c with SMTP id
 u25-20020aa7d999000000b0040efdf0038cmr4933830eds.419.1645136017495; Thu, 17
 Feb 2022 14:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20220215053844.7119-2-Frank.Li@nxp.com> <20220217215358.GA308489@bhelgaas>
In-Reply-To: <20220217215358.GA308489@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 17 Feb 2022 16:13:27 -0600
Message-ID: <CAHrpEqSFe5=2VNrjbZwiiVkBQ46K6+bEVDNEXJMo58UXQNkJ5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] PCI: designware-ep: Allow pcie_ep_set_bar change
 inbound map address
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 17, 2022 at 3:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> In the subject, "pcie_ep_set_bar" looks like *part* of a function
> name.  Please include the entire function name and add "()" after it.

Okay

>
> On Mon, Feb 14, 2022 at 11:38:41PM -0600, Frank Li wrote:
> > ntb_transfer will set memory map windows after probe.
> > So the inbound map address need be updated dynamtically.
>
> I don't see "ntb_transfer" in the tree.  If it's a function, please
> add "()" after the name.  Otherwise, please say more about what
> "ntb_transfer" is.

Thanks.  That's ntb_mw_set_trans() at drivers/ntb/ntb_transport.c.

>
> s/dynamtically/dynamically/
>
> Please make the commit log say what the patch *does*, not just what
> needs to happen.

Okay,  this patch allows changing PCI BAR's address.  For example,
previous BAR0 map to physical address to 0xF1000000, now can change
to new physical address 0xF2000000 by call function pci_epc_set_bar()

The patch 3/4 is totally new method to make NTB work at RC and EP system,
I hope the basic structure is acceptable.

>
> Bjorn
