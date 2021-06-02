Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1529B39900C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFBQfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhFBQfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 12:35:15 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE98C061574;
        Wed,  2 Jun 2021 09:33:31 -0700 (PDT)
Received: from dellmb (unknown [IPv6:2001:1488:fffe:6:8747:7254:5571:3010])
        by mail.nic.cz (Postfix) with ESMTPSA id B1DE2140A37;
        Wed,  2 Jun 2021 18:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1622651608; bh=bTg4ZWrVnYrtMbqxogxXsBiqmruzHvbu7w0ovkbBTGo=;
        h=Date:From:To;
        b=ShZNHjVdtmTDn/yUFZ7jH1VdEaaDlpKh53Be8Uof3R8TVl5ZnGB72e/0248kZES7t
         +yY30ueSJkij+W/B0o+zbe6E/y5dGrGbQK16r5McJZN/n3qD6KnqprzmBnoloZS6tH
         JoJA/teyI7oFP9tHcaOFuMVNaC9NywX/V4jp2Lg4=
Date:   Wed, 2 Jun 2021 18:33:28 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
Message-ID: <20210602183328.1e5885dc@dellmb>
In-Reply-To: <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
        <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
        <20210601223812.GA5128@amd>
        <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Jun 2021 22:18:16 -0500
stuart hayes <stuart.w.hayes@gmail.com> wrote:

> Both Bjorn Helgaas and Krzysztof Wilczy=C5=84ski had suggested the=20
> scheduler-type interface, so I went with that.  In an earlier attempt
> at this driver, when Bjorn suggested this, he asked if that would
> violate the "one value per file" rule, and Greg K-H responded "That's
> a valid way of displaying options for a sysfs file that can be
> specific unique values."

But you are not displaying unique values. Your example is

# echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
# cat /sys/class/leds/0000:88:00.0::drive_status/states
[ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled

so there are 2 values set (ok and locate). Unique means that only one
can be set.

Question: can this LED be configured by userspace? I mean: can you
configure whether the LED should be on/off, disregarding the SSD state?

I ask because the LED subsystem currently officially does not
support LEDs for which brightness cannot be set by userspace...

If yes, you should implement the .brightness_set() function. (Could you
please also send your patch to the linux-leds mailing list?)

Then you should implement a LED-private trigger for this LED, which,
when enabled, will make the LED follow the SSD state.

The sysfs ABI should probably look like this:

# cd /sys/class/leds/<SSD_LED>
# echo 1 >brightness		# to light the LED on
# echo 0 >brightness		# to light the LED off
# echo ssd_state >trigger	# to make the LED follow SSD states
# ls ssd_state			# list available SSD states
ok  locate  failed  rebuild ...
# cat ssd_state/ok		# check if "ok" state is enabled
0
# echo 1 >ssd_state/ok		# enable "ok" state so that the
				# LED will be on when SSD is in "ok"
				# state
# echo none >trigger		# put the LED back into SW mode

(The name of the trigger does not necessarily have to be "ssd_state".
 Other people should give their opinions about the name.)

Marek
