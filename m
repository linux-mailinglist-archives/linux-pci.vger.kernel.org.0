Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323344801B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 14:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhKHNRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 08:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhKHNRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 08:17:33 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460DFC061570;
        Mon,  8 Nov 2021 05:14:49 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 193so3595655qkh.10;
        Mon, 08 Nov 2021 05:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YiIUTTNlB+7iJnN/pxtQL19HoA8uaMjwhabdvamkyo0=;
        b=IxC9lx1a4lGpBuLRhVfWH8s/b3hhh5XuQdOtYYhQlO7g0LGsmn8oXxVNRvrSYVwDQ7
         astbpRq5D/e1qyVrE+0AlUWM/V+lefyq3pAGHphDdF1cquhHwD9yEcgWs2kfIWBC7vPO
         2T16M15MeMduPZuJwB7Y+FoB0gX5QXg+TQdXBtqGd0DiTMgV6oYrhcymz7hQgRCrSE8A
         DeIW/P7qA8JclPoVgwGZzLHb60K9DNFqFTO7GUU+QKp8cnrOZiDw0IF4YchnjPVqj/vL
         JoGPBvS7ZMYlVO+Zq09wlCo4GK4KhdoNPSbi4/aX4+moVtB2vHTAaKv6xggFu/9zyuKO
         yYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YiIUTTNlB+7iJnN/pxtQL19HoA8uaMjwhabdvamkyo0=;
        b=zaGWINXMFPSjIFrj99C+5+q8OzWaBiDESXnmzlkpQIy+XvWFzcjYTFLJXrnwHutNSS
         pnc+2NjgbjMEi+GvbHumxsdgjvZL3Ri3M/jLwTM1yWC0tTYJnqcWUcHEcgV0/7KmWfHH
         eCI8Sc+hKaujTXXYNU6cJdlO0B7U+pY7Q5MwHIgBGz5ygU25RQCIKnaKJP+unzPIa/gZ
         xEHA0LfNYz4GexV6hBKYPjQRie9+0Vm/GBjz4SKkImFFwQUnyFqtL+zpR4C4or4AQr5B
         Ib/ETCL/I9wm3cbxocCEm1/6nL+WM/QhEphEFbX6cdt3i6r56PLYUtnqDVUMHM3dbVdB
         pMcg==
X-Gm-Message-State: AOAM530mhQTh7xrg9qOTYTJrz0KntNZk2bXvdPWmyFd/1neMBurZ/dNQ
        fHZ4XTobRScCP6cXh+BO39RYdEMH5SED9TVymyc=
X-Google-Smtp-Source: ABdhPJzrpMYud3QMCcBQHkX1eBqEWZPGP6pT2UZUMNzDWdRryTFS7wiWsBOJD55xrHMXwjsaysv68bOHvIgkToiKlec=
X-Received: by 2002:a37:6254:: with SMTP id w81mr6740477qkb.391.1636377287167;
 Mon, 08 Nov 2021 05:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20211022183808.jdeo7vntnagqkg7g@pali>
In-Reply-To: <20211022183808.jdeo7vntnagqkg7g@pali>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 9 Nov 2021 00:14:36 +1100
Message-ID: <CAOSf1CG65t0OZuB87z3m9AVBOjAQL_5nNRak+UjX7fOQJDCH0A@mail.gmail.com>
Subject: Re: RFC: Extend probing of native PCIe controllers
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 23, 2021 at 5:38 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> In this email I'm describing how I see that probing of native PCIe
> controller drivers is implemented, how it should be implemented and how
> to extend / simplify core code for controller drivers.
>
> Native PCIe controller drivers needs to fill struct pci_host_bridge and
> then call pci_host_probe(). Function pci_host_probe() starts probing and
> enumerating buses and register PCIe devices to system.
>
> But initialization of PCIe controller and cards on buses (other end of
> PCIe link) is more complicated and basically every native PCIe
> controller driver needs to do initialization PCIe link prior calling
> pci_host_probe(). Steps which controller drivers are doing are de-facto
> standard steps defined in PCIe base or CEM specification.
>
> The most problematic step is to reset endpoint card and wait until
> endpoint card start. Reset of endpoint card is done by standard PERST#
> signal (defined in PCIe CEM spec) and in most cases board export control
> of this signal to OS via GPIO (few board and drivers have this signal
> connected to PCIe controller and then PCIe controller has some specific
> registers to control this signal). Reset via PERST# signal is defined in
> PCIe CEM and base specs as "PCIe Warm Reset".
>
> As discussed in the following email thread, this PCIe Warm Reset should
> not depend on PCIe controller as it resets card on the other end of PCIe
> controller. But currently every native PCIe controller driver does PCIe
> Warm Reset by its own for randomly chosen time period. There is open
> question how long should be endpoint card in Warm Reset state:
> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
>
> Initialization of PCIe endpoint card is described in PCIe CEM spec in
> Figure 2-10: Power Up. Other informations are in PCIe base spec in 6.6.1
> Conventional Reset section.
>
> If I understand specifications correctly then OS initialization steps
> should be following (please correct me if I'm wrong!):
>
> 1) Put PERST# to low which enter endpoint card into reset state
> 2) Enable AUX power (3.3V) and wait until is stable
> 3) Enable main power (12V/3.3V) and wait until is stable
> 4) Enable refclock and wait until is stable
> 5) Enable LTSSM on PCIe controller to start link training
> 6) Put PERST# to high which exit endpoint card from reset state
> 7) Wait until link training completes
> 8) Wait another 100ms prior accessing config space of endpoint card
>
> Minimal time period between "after step 3)" and "before step 6)" is T_PVP=
ERL =3D 100ms
> Minimal time period between "after step 4)" and "before step 6)" is T_PER=
STCLK =3D 100us
>
> After step 6) is end of Fundamental Reset and PCIe controller needs to
> be in LTSSM Detect state within 20ms. So enabling it prior putting
> PERST# to high should achieve it.

5) is a bit out of place here and it could be step 0). There's no real
requirements around when the upstream device (the controller in our
case) starts polling for downstream devices. #PERST is effectively a
power good signal so the downstream device is required to ignore the
link polls until #PERST is lifted.

> Competition of link training is indicated by standard DLLLA bit in Root
> Port config space. Support for DLLLA bit is optional and is indicated by
> DLLLARC bit in Root Port config space. Lot of PCIe controllers do not
> support this standard DLLLA bit, but have their own specific register
> for it.

I thought DLLLA reporting was made mandatory in gen2? I suppose it
doesn't really matter since we need to support gen1 devices anyway,
but still...

> Similarly is defined power down of PCIe card in PCIe CEM spec in Figure
> 2-13: Power Down. If I understand it correctly steps are:
>
> 1) Put endpoint card into D3hot state, so PCIe link goes inactive
> 2) Put PERST# to low, so endpoint card enters reset state
> 3) Disable main power (12V/3.3V)
> 4) Disable refclock
>
> In case of surprise power down, PERST# needs to go low in 500ns.
>
> In PCIe base spec in section 5.2 Link State Power Management is
> described that preparation for removing the main power source can be
> done also by sending PCIe PME_Turn_Off Message by Root Complex. IIRC
> there is no standard way how to send PCIe PME_Turn_Off message.

Is there any real difference between sending this message and placing
the device into D3hot? IIRC devices in D3hot are required to tolerate
a transition to D3cold (i.e. power being removed) anyway.

> I see that basically every PCIe controller driver is doing its own
> implementation of PCIe Warm Reset and waiting until PCIe link is ready
> prior calling pci_host_probe().
>
> Based on all above details I would like to propose following extending
> of struct pci_host_bridge and pci_host_probe() function to de-duplicate
> native PCIe controller driver code:
>
> 1) extend struct pci_host_bridge to provide callbacks for:
>    * enable / disable main power source
>    * enable / disable refclock
>    * enable / disable LTSSM link training (if PCIe link should go into De=
tect / Polling state)
>    * enable / disable PERST# signal
>    * returning boolean if endpoint card is present (physically in PCIe/mP=
CIe/m.2/... slot)
>    * returning boolean if link training completed
>    * sending PCIe PME_Turn_Off message

I don't have any real objections to adding this, but I do wonder what
code would be using these calls. If you squint a bit you've got
something that looks a lot like a pci hotplug slot driver (enable /
disable / presence check calls). It might make sense to try use some
of that infrastructure for what you want to do since the bus scanning
code already knows how to deal with slot drivers.

> 2) implement asynchronous initialization of PCIe link and enumeration of
>    PCIe bus behind the PCIe Root Port from pci_host_probe() based on new
>    callbacks added in 1)
>    --> so native PCIe controller drivers do not have to do it manually
>    --> during this initialization can be done also PCIe Hot Reset
>
> 3) implement PCIe Hot Reset as reset method via PERST# signal and put it
>    into pci_reset_fn_methods[] array

I assume you mean Warm reset here. I'll add a word of caution that
there are badly behaved devices out there which will ignore #PERST
being re-asserted after the card is powered on.

> 4) implement PCIe Cold Reset as reset method via power down / up and put
>    it into pci_reset_fn_methods[] array
>
> 5) as enabling / disabling power supply and toggling PERST# signal is
>    implemented via GPIO, add some generic implementation for callback
>    functions which will use named gpios (e.g. from DT)
>
> This could simplify implementations of native PCIe controller drivers by
> calling initialization steps in correct order with correct timeouts and
> drivers do not have to do copy+paste same common code or reimplement it
> with own constants and macros for timeouts, etc...
>
> Also it should enable access to PCIe Root Port as this device is part of
> Root Complex and should be available also when link is down or link
> training was not completed. Currently some PCIe controllers are not
> registered into system when link is down (e.g. card is disconnected or
> card has some issue). Which also prevents access to PCIe Root Port
> device.

Is there a good reason for skipping probing the controller when
there's no downstream device present? Seems kinda dumb to make a whole
pci domain disappear just because it didn't have a device at boot.

> And in some cases it could speed up boot process as pci
> controller driver does not have to actively wait for link and let kernel
> do initialization of other devices.

> What do you think about this idea?

Sounds like a good idea to me.
