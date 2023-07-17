Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C1755D5D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGQHrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjGQHrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 03:47:42 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99019A5
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 00:47:21 -0700 (PDT)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 59FC13F731
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689580038;
        bh=3gAfaAKrcJgIAcFAT2kE7R0UfBXH+B9pPbdV57Y5Wuk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iy8tUaMF6mIyILPq+D7VR6/9yi8oC90Tc/h3Sdtbzj1xqvkCOPNdxM6Gi813fviW5
         5kpPeMWKtzFK0AiznlpbUIqxyY5TVfTijcJWuAUS9rl+hyel+QXwMPl+qZqqN2tt+f
         Iey7Fqj9/x8F6CVRiL2Secgz5/298PL3yHEb6guRfkAUIl1vfokSbuIS5RsRpvYH2e
         j1oYYP2Rodp7F48B3MmtZN4utUKtT8fHmvqzlVjFC87eHqomUr6tnycpTqG/JMSfAa
         DKrVNlkSykyHYv6DVAg9QLQY2JV5IbJxWOLd5X2f/Ay35dxm5+DTcb1vJh9qce3C8S
         x04SCXhU3cGow==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-560ce5f7646so5520475eaf.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 00:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580036; x=1692172036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gAfaAKrcJgIAcFAT2kE7R0UfBXH+B9pPbdV57Y5Wuk=;
        b=ek3AqanEAQpZzLuRl29c5yL9ariIF+q7ZWkT2dkELfZ/FSP5fa7APcs08dUWd9JaxT
         h2HPNmrqZQTMJOfNRL51PYJtS1oLzY1UAMyYJ6VzlyxHxb5tJduycPtjJKCAwJfFxC3D
         ahAqZQwFybRyVRYLhl7x4GZNXRol0T1fIt5gliMIsdt8MKUKBjrqtnPOF//A9wCdSkf7
         +jMqENMIjXzVIqssI0pkDdT/MkvUTqewtlE+cgkiOvQtCZuUEF2AaIcUQ0kBQkuLNrvr
         vmDKlcGH0TZM47G2MbJGl94Zuno691PIcWN9v4kInvtRMmXUUDqZyJ7zUmOM+laSmeC2
         rKqQ==
X-Gm-Message-State: ABy/qLaITGDHch+h6CSJsrUSTHC7JYlD34CFva624K+GU9z6FBSH/rLY
        jcz9C4jZ+QGGIzka3/TJdXmL1QxU3xf9BJlv+V611r7ajGX14Yqmr33o/7bzex1z6v/OjJFX+Ot
        a63QCoOq/h9WwxmT2J58ZZjdvZv+EuSVemiX05LzOaRo2DVN+wpxvRw==
X-Received: by 2002:a05:6358:4291:b0:133:291:f9ac with SMTP id s17-20020a056358429100b001330291f9acmr8421567rwc.25.1689580035717;
        Mon, 17 Jul 2023 00:47:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9DoONFKdmsKqUh/LuGSuwifc1GAuZNV44ZqW0/u5tIfGEjz1hRCf3IVbFGKMGLXWKhFrokqQ0Xv8dAN/JWlM=
X-Received: by 2002:a05:6358:4291:b0:133:291:f9ac with SMTP id
 s17-20020a056358429100b001330291f9acmr8421558rwc.25.1689580035356; Mon, 17
 Jul 2023 00:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <874jm6nsd0.fsf@intel.com> <20230715191216.GA364070@bhelgaas>
In-Reply-To: <20230715191216.GA364070@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jul 2023 15:47:04 +0800
Message-ID: <CAAd53p6SiQrmjWA3=4CE0tw15-ZfmkcqTNoheXzkkkargfGtCw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] igc: Ignore AER reset when device is suspended
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        anthony.l.nguyen@intel.com, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 16, 2023 at 3:12=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 14, 2023 at 01:35:55PM -0700, Vinicius Costa Gomes wrote:
> > Bjorn Helgaas <helgaas@kernel.org> writes:
> > > On Fri, Jul 14, 2023 at 01:05:41PM +0800, Kai-Heng Feng wrote:
> > >> When a system that connects to a Thunderbolt dock equipped with I225=
,
> > >> like HP Thunderbolt Dock G4, I225 stops working after S3 resume:
> > >> ...
> > >
> > >> The issue is that the PTM requests are sending before driver resumes=
 the
> > >> device. Since the issue can also be observed on Windows, it's quite
> > >> likely a firmware/hardware limitation.
> > >
> > > Does this mean we didn't disable PTM correctly on suspend?  Or is the
> > > device defective and sending PTM requests even though PTM is disabled=
?
> >
> > The way I understand the hardware bug, the device is defective, as you
> > said, the device sends PTM messages when "busmastering" is disabled.
>
> Bus Master Enable controls the ability of a Function to issue Memory
> and I/O Read/Write Requests (PCIe r6.0, sec 7.5.1.1.3).  PTM uses
> Messages, and I don't think they should be affected by Bus Master
> Enable.
>
> I also don't understand the I225 connection.  We have these
> Uncorrected Non-Fatal errors:
>
> > >> [  606.527931] pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non=
-Fatal) error received: 0000:00:1d.0
> > >> [  606.528064] pcieport 0000:00:1d.0: PCIe Bus Error: severity=3DUnc=
orrected (Non-Fatal), type=3DTransaction Layer, (Requester ID)
> > >> [  606.528068] pcieport 0000:00:1d.0:   device [8086:7ab0] error sta=
tus/mask=3D00100000/00004000
> > >> [  606.528072] pcieport 0000:00:1d.0:    [20] UnsupReq              =
 (First)
> > >> [  606.528075] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a=
000052 00000000 00000000
> > >> [  606.528079] pcieport 0000:00:1d.0: AER:   Error of this Agent is =
reported first
> > >> [  606.528098] pcieport 0000:04:01.0: PCIe Bus Error: severity=3DUnc=
orrected (Non-Fatal), type=3DTransaction Layer, (Requester ID)
> > >> [  606.528101] pcieport 0000:04:01.0:   device [8086:1136] error sta=
tus/mask=3D00300000/00000000
> > >> [  606.528105] pcieport 0000:04:01.0:    [20] UnsupReq              =
 (First)
> > >> [  606.528107] pcieport 0000:04:01.0:    [21] ACSViol
> > >> [  606.528110] pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04=
000052 00000000 00000000
>
> They are clearly Unsupported Request errors caused by PTM Requests
> (decoding at https://bugzilla.kernel.org/show_bug.cgi?id=3D216850#c9),
> but they were logged by 00:1d.0 and 04:01.0.
>
> The hierarchy is this:
>
>   00:1d.0 Root Port to [bus 03-6c]
>   03:00.0 Switch Upstream Port to [bus 04-6c]
>   04:01.0 Switch Downstream Port to [bus 06-38]
>   06:00.0 Switch Upstream Port to [bus 07-38]
>   07:04.0 Switch Downstream Port to [bus 38]
>   38:00.0 igc I225 NIC
>
> If I225 sent a PTM request when it shouldn't have, i.e., when 07:04.0
> didn't have PTM enabled, the error would have been logged by 07:04.0.
>
> The fact that the errors were logged by 00:1d.0 and 04:01.0 means that
> they were caused by PTM requests from 03:00.0 and 06:00.0.

OK, so the PTM is actually fired by the Thunderbolt switch.
That means the I225 reset is collateral damage.
Let me see if I can reproduce the UR PTM with other devices.

Kai-Heng

>
> Bjorn
