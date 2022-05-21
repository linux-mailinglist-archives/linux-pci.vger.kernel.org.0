Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680F452FA09
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiEUIgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 May 2022 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiEUIgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 May 2022 04:36:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C536310;
        Sat, 21 May 2022 01:36:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so9111268plh.2;
        Sat, 21 May 2022 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ei1w+gAULw3a4Sp90/wPAPVRhqkQXbusQfV0z240l4M=;
        b=E+7bjb/QwmEkUO8deR/PhBs6U3gxuFDSHnbQU7gNn3QKPN5mF5qRPTZ0GWj4l8In3L
         4CRgnUMOcbQlDkqioBvhvd1qNGKDjF6Ee1CXwHfqv7aJwjfS8h63grHDSlmaCp4fLwfM
         kNjWHzEvFnz+pXk+OmQrrDVb6ceE2aYycr6917ddc/9/wh8Z/llY2Ii1XhQkb49vjGTw
         fqrQC31FXiDfugJcYscTRQU0PLWKXFRBlgNw2hqtSy3QW5V+XU+uwTDZqrZqbo41Ql4C
         GqgPEr0rJKaEvkSIaCnoD5ZlU8KYD2g6n1Is53prmCWsPY0hgXBLaEnpvUmoc6jueFfR
         qHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ei1w+gAULw3a4Sp90/wPAPVRhqkQXbusQfV0z240l4M=;
        b=Uh5B0GjgnhomGRlr3TZq3rjS8zq7c6twpZTKU3bJ5bWA45tmV1lMfXlORsWCBS3/j+
         evwg3L4zTVrIERfS/54fYhDw50cyV9xqBargpfLA/107LBC1ffT3Dll4FtsvyQvfOo5L
         D6F1/QqvNAHOzh45NfTq+gEjbHn+qyTo6Qyv8GQKsvOWp3yyjru+D84Qv9dWTgNfMS7s
         XwG6fNeziHONVUhdsezcl+o9MkFTWlVgnq7H+zZI+NTvXAWMuLfBrsqY7HfLuVoTqdXt
         FPeFkspG0AlT0kzCaVYsXrViSx9yWwWzHe3AnIQXhZMJq3UZy1U+QQM+jTZzVxtiEbpx
         fI2w==
X-Gm-Message-State: AOAM533PO+Mmz8CH0e294bLOCI6urANqIIj67QUao7SCtghiDa1DPn9Q
        kxua4Jx0wNadR+J7zLqBrxptcfoRjBnThIsRm8Q=
X-Google-Smtp-Source: ABdhPJwca2rFA5Q4M2AyfKg+2grC+dgJOl8pPVHGfhRhV0GOIoUoBTya/l9pec68R6KTBNux4R19JJmJXZDZZU9gGbg=
X-Received: by 2002:a17:903:40cb:b0:162:6ea:a2 with SMTP id
 t11-20020a17090340cb00b0016206ea00a2mr1789753pld.34.1653122183639; Sat, 21
 May 2022 01:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165740.6256af51.alex.williamson@redhat.com>
 <20220518115432.76183-1-windy.bi.enflame@gmail.com> <20220520064148.GA20418@wunner.de>
In-Reply-To: <20220520064148.GA20418@wunner.de>
From:   Sheng Bi <windy.bi.enflame@gmail.com>
Date:   Sat, 21 May 2022 16:36:10 +0800
Message-ID: <CAGdb+H2_pX4TzG=sJ8XE6KiyWW9niJQawCbcDN2byxDfybukiA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, May 20, 2022 at 2:41 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 18, 2022 at 07:54:32PM +0800, Sheng Bi wrote:
> > +static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> > +{
> > +     struct pci_dev *dev;
> > +     int delay = 0;
> > +
> > +     if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> > +             return 0;
> > +
> > +     list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> > +             while (!pci_device_is_present(dev)) {
> > +                     if (delay > timeout) {
> > +                             pci_warn(dev, "not ready %dms after secondary bus reset; giving up\n",
> > +                                     delay);
> > +                             return -ENOTTY;
> > +                     }
> > +
> > +                     msleep(20);
> > +                     delay += 20;
> > +             }
> > +
> > +             if (delay > 1000)
> > +                     pci_info(dev, "ready %dms after secondary bus reset\n",
> > +                             delay);
> > +     }
> > +
> > +     return 0;
> > +}
>
> An alternative approach you may want to consider is to call
> pci_dev_wait() in the list_for_each_entry loop, but instead of
> passing it a constant timeout you'd pass the remaining time.
>
> Get the current time before and after each pci_dev_wait() call
> from "jiffies", calculate the difference, convert to msecs with
> jiffies_to_msecs() and subtract from the "timeout" parameter
> passed in by the caller, then simply pass "timeout" to each
> pci_dev_wait() call.

Thanks for your proposal, which can avoid doing duplicated things as
pci_dev_wait().

If so, I also want to align the polling things mentioned in the
question from Alex, since pci_dev_wait() is also used for reset
functions other than SBR. To Bjorn, Alex, Lucas, how do you think if
we need to change the polling in pci_dev_wait() to 20ms intervals, or
keep binary exponential back-off with probable unexpected extra
timeout delay.

>
> As a side note, traversing the bus list normally requires
> holding the pci_bus_sem for reading.  But it's probably unlikely
> that devices are added/removed concurrently to a bus reset
> and we're doing it wrong pretty much everywhere in the
> PCI reset code, so...

Yeah... I think that is why I saw different coding there. I would
prefer a separate thread for estimating which ones are real risks.

>
> (I fixed up one of the reset functions with 10791141a6cf,
> but plenty of others remain...)
>
> Thanks,
>
> Lukas
