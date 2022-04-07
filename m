Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F44F82A9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiDGPTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344536AbiDGPTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 11:19:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D81FAA16
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 08:17:32 -0700 (PDT)
Received: from [IPv6:2a0d:e40:0:4000:a33d:5e2a:b8b4:d3c4] (unknown [IPv6:2a0d:e40:0:4000:a33d:5e2a:b8b4:d3c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nuclearcat)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 334AA1F46738;
        Thu,  7 Apr 2022 16:17:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649344636;
        bh=eqdBhYFXk2+shgFwF1nr+P2hRU49oMgaFpfC5YLl8Zg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aAHpWocKfyJNUZWPw9SHPN5wGitFQmwjLGlAOvr0FxtuU+hXco7POkyI0HV7b9b4G
         JI67mF45ipaEtMxPH8cYPhIhNJAZeTzUf/ZYyL7r93kwFwMaQJZhWvbssUcK6bs1th
         B/d/6ZBnf5Ma+3/f+VfdUqNn2Rfy0JVhs/LHhbI50vnIo4oA1B6p07Jcx/aX3OjBGQ
         +QUPlgIDaCwWvQaE+cq1Rb7auqPt2enrhaeBqxK6pM/8o3yRBH1c2yVssvUsH4+8rS
         wXaU0oFq2xu0UO4zrysUJuwNSim/hnAjihaKQF9C+EZ2ZZN0x49YdJ5ffl0Dfl2U1O
         U195CbmZPKzQg==
Message-ID: <ce2c9ca3cdb05c78c644012002bd789a2108a147.camel@collabora.com>
Subject: Re: next/master bisection: baseline.login on
 asus-C523NA-A20057-coral
From:   Denys Fedoryshchenko <denys.f@collabora.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, linux-pci@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "kernelci@groups.io" <kernelci@groups.io>,
        =?UTF-8?Q?Micha=C5=82_Ga=C5=82ka?= <michal.galka@collabora.com>
Date:   Thu, 07 Apr 2022 18:17:11 +0300
In-Reply-To: <52fd4165-2e95-e9dc-79cf-63b2a8274d30@collabora.com>
References: <20220405235315.GA101393@bhelgaas>
         <20220406185931.GA165754@bhelgaas> <Yk3r9uhIHmNumtxi@sirena.org.uk>
         <52fd4165-2e95-e9dc-79cf-63b2a8274d30@collabora.com>
Content-Type: multipart/mixed; boundary="=-bvrjnpvUG+Y4CBw13Bg+"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-bvrjnpvUG+Y4CBw13Bg+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2022-04-06 at 21:11 +0100, Guillaume Tucker wrote:
> +kernelci +Michał +Denys
> 
> On 06/04/2022 20:37, Mark Brown wrote:
> > On Wed, Apr 06, 2022 at 01:59:31PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 05, 2022 at 06:53:17PM -0500, Bjorn Helgaas wrote:
> > 
> > > > Is there any way to get the contents of:
> > 
> > > >   /sys/firmware/acpi/tables/DSDT
> > > >   /sys/firmware/acpi/tables/SSDT*
> > 
> > > > from these Chromebooks?
> > 
> > > Is there hope for this, or should I look for another way to get
> > > this
> > > information?
> > 
> > I believe Guillaume is out of office this week.  Copying in Guenter
> > as
> > well since he's on the ChromeOS team in case he can help or knows
> > someone who can.
> 
> Someone with access to the Collabora LAVA lab can also send a
> custom job to try and get this information.
> 
> I'm back to work on Monday.
> 
> Thanks,
> Guillaume
Hi All

Device-type: asus-C523NA-A20057-coral
Thats all i got, it is only one SSDT table.

Please let me know if anything else needed.



Best regards,
Denys Fedoryshchenko


--=-bvrjnpvUG+Y4CBw13Bg+
Content-Type: application/x-compressed-tar; name="acpi.tgz"
Content-Disposition: attachment; filename="acpi.tgz"
Content-Transfer-Encoding: base64

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
n/fs5fA6vA6vw+vw+v+u/wCgYulAAFAAAA==


--=-bvrjnpvUG+Y4CBw13Bg+--

