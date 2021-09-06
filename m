Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE3401625
	for <lists+linux-pci@lfdr.de>; Mon,  6 Sep 2021 08:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhIFGCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Sep 2021 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbhIFGCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Sep 2021 02:02:36 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132BC061575
        for <linux-pci@vger.kernel.org>; Sun,  5 Sep 2021 23:01:32 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id x23so3219408uav.3
        for <linux-pci@vger.kernel.org>; Sun, 05 Sep 2021 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ra13Dsxp/lFjQLeOJgt5Puq9qJBrmKS4Mb+LX2vvhx4=;
        b=ClqmfZ0kHX74phmy+Ie+vc8TGY+lODHdeyA3bqDzXKasvoR18O3iEh+zC3U2UbZoMk
         +PDMWNXpkf29isTTcFMhqsdXRDv49z5eyCl6gdahbRbTclvRG1/d4XHWWOT+aW/66Vhn
         z4onP7xlv0g/fRPaXb8/JRvOh+7DHsA2dmMHjRygeyDYJTxl2C4k5/E30snEQH2lz1ze
         gMv2VLS+cfYKnEM/TqC5Gzrhk4CUxt6niGwthQfMs8r0DWQDYw6IDlJ8e7gmQqZGD0a7
         bf27RAr3wsk+JQhDBx51ghhI9mmGkIF6fC+jgrSCzGBRIgFIdzzoCinaaagiDQxkYq2E
         O2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra13Dsxp/lFjQLeOJgt5Puq9qJBrmKS4Mb+LX2vvhx4=;
        b=oRJQEmipcIZj+CrBuv+0YcX4u4qVgqGc4TY8TJgBA6TlTXU1CFL1+Qzl0r+33ivVk2
         KiUwluQ4jOQQ50Y5YALel3VJJo6E9xZ8KROMpiLIfd1OSzTREImRv1Gdfd0ZGX5iUmQt
         IwjZxvpc7tJ4QIGACY4JzaMLJYGnmueGU35cTJ/xWdwWz4ZKNvMkWsxEzAFz6Mp9r+xM
         3LkxLUq/MMeHmQBtVQT5k3nFvbl7IJ2xfPzIsZ9i8/LokRXvvcA0KpsXDUj95Z8HnWYy
         sKBTRggxDNlv7Lz5sqTzkbgl3eJw5Xp76URzXaDt5jBS+TEMiV/S24s8ohDPbdn5upgV
         tzag==
X-Gm-Message-State: AOAM532IFAo/atg4RvIoHXjgRHHpzALcpeYVBSZ8Fjzr1de2dITOCzYK
        dNatlb8lRRRD9EK+UdYjiSJd3u/kr+BOxr5HB2rQKeS/AaM=
X-Google-Smtp-Source: ABdhPJzCjiwoB/K8Guk6E/WcTiTnTKQT7rvkUT7YYhDZ/9eK274tqMjgevrPSTMu3MCHbbDFJT20JCvwYNFlsTT5BLM=
X-Received: by 2002:ab0:6218:: with SMTP id m24mr4674118uao.7.1630908091852;
 Sun, 05 Sep 2021 23:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210903034029.306816-1-nathan@nathanrossi.com> <20210903061814.GA15994@wunner.de>
In-Reply-To: <20210903061814.GA15994@wunner.de>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Mon, 6 Sep 2021 16:01:20 +1000
Message-ID: <CA+aJhH1qagpz6qPEYLnO6UMuh_U5uCK3tzdoGJyR9Y73MOmneQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Sept 2021 at 16:18, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Sep 03, 2021 at 03:40:29AM +0000, Nathan Rossi wrote:
> > The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
> > Redirect behaviour when used in the cut-through forwarding mode. The
> > recommended work around for this issue is to use the switch in store and
> > forward mode.
> >
> > This change adds a fixup specific to this switch that when enabling the
> > downstream port it checks if it has enabled ACS P2P Request Redirect,
> > and if so changes the device (via the upstream port) to use the store
> > and forward operating mode.
>
> From a quick look at the datasheet, this switch seems to support
> hot-plug on its Downstream Ports:
>
> https://www.diodes.com/assets/Datasheets/PI7C9X2G404SL.pdf
>
> I think your quirk isn't executed if a device is hotplugged to an
> initially-empty Downstream Port.

The device I am testing against has the ports wired directly to
devices (though can be disconnected) without hotplug so I will see if
I can find a development board with this switch to test the hotplug
behaviour. However it should be noted that the downstream ports are
probed with the switch, and are enabled with the ACS P2P Request
Redirect configured regardless of the presence of a device connected
to the downstream port.

>
> Also, if a device which triggered the quirk is hot-removed and none
> of its siblings uses ACS P2P Request Redirect, cut-through forwarding
> isn't reinstated.

The quirk is enabled on the downstream port of the switch, using the
state of the downstream port and not the device attached to it. My
understanding is that the only path that enables/disables the ACS P2P
Request Redirect on the downstream port is the initial pci_enable_acs.
This means that devices attached to the downstream port either
initially or with hotplugging should not change the ACS configuration
of the switches downstream port.

Which means nothing can cause the switch to need to be reinstated with
cut-through forwarding except the switch itself being hotplugged,
which would cause reset of the switch and the enable fixup to be
called again.

Thanks,
Nathan

>
> Perhaps we need additional pci_fixup ELF sections which are used on
> hot-add and hot-remove?
>
> Thanks,
>
> Lukas
