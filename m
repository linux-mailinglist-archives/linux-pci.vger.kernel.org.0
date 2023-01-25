Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8D67BC81
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjAYU0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 15:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjAYU0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 15:26:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A73028B;
        Wed, 25 Jan 2023 12:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674678342; bh=CJpm4j5WqE7F3iRYq1S3DuSbryZhT069+nPX/zvi+bs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=V9ok/lQnUyyS3t2OfQcz6fyi1hPhg0Zd/g/uQJkDX/dJGpV+tivroGjbFhe8IYUOf
         Am+UKcCVYKUXidEdBCh/UQx+jjcwzjXeB16f8T67r3ZM0fhtQu03TpzthlWFAaLMsh
         t0qNuS3+tSSU27V0Hlfuxuyr+lrzc8GwHYT0oUeTm3uK5i9RDJtbWzXJoXKos2bjjC
         58vGdW1LTL7L36rg96X0vDQiR7LrIRTOWb93gf5snPAkABqWr+GRArY8OrncR7LKoO
         PqOixaC94GLjXGa33+Sxl4ttrj0Ktd891AS1EHFk8YAW/DQQxHxzIpNHczxoMmRik/
         LUlpgNE+KvTSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from methusalisk.wuest.de ([84.148.50.251]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M6lpM-1pKE6y2tQ6-008NuF; Wed, 25 Jan 2023 21:25:42 +0100
Received: from dolon (dolon.wuest.de [192.168.0.179])
        by methusalisk.wuest.de (Postfix) with ESMTP id EF4092C01A4;
        Wed, 25 Jan 2023 21:25:40 +0100 (CET)
Date:   Wed, 25 Jan 2023 21:25:40 +0100
From:   Daniel Scheller <d.scheller@gmx.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Berni <bernhard@turmann.eu>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 208507] New:
 BISECTED: i2c timeout loading module ddbridge with commit
 d2345d1231d80ecbea5fb764eb43123440861462]
Message-ID: <20230125212540.54d967cc@dolon>
In-Reply-To: <20230125170506.GA1175690@bhelgaas>
References: <20200709191722.GA6054@bjorn-Precision-5520>
        <20230125170506.GA1175690@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hOiHlGCUCbcOAJKvIxj8VK3sVF3IyFIrl/z+CLbUCkzUzd6JpyF
 8NUccm+OgflFbFoEpf3h9T0q5Wm+ZsgtDSYZsyJazmCl+DlOi11mkq1LBGm7KSHcVBkIhm2
 yU+26mwGp0SKa+O/HX7qHsmmGzBh0hL239UDVf6X7jBO40H7ZYD8uYuoDyiPdaoe6i/47ua
 JbVA+uvzR7pzk7MWe2Ipw==
UI-OutboundReport: notjunk:1;M01:P0:uTnuksO/OLw=;OBgQllEbNiOsN9MHXuDrDzIy0gy
 k1qpKgUgkhkOI9eUc39Sdd375OJIhnHfid0erdiT4p+XUliuPKeqNwUfkXnWXYR1W4DkGgBCY
 4950JEBaPfo+BvhIOYIAOGlBIW9sud3Oyl6QjEyUsrcgoPuoLAIaM7uUR23MX9AuCvsGVyda+
 0+praQFgTf+fHLji449fDVQA9MAMqSjAZ04+lFYIJOp94QA2LuRz/jXBOz1fOtBoXg61+uom4
 /V3VBBlXTMVv2CpROHJH9AOlb/cEqww6nI0pu1yc8hlO8qdCBG4OVvQ3QsTb48YR10cc1iZvm
 SBwkvLRiSM9t4VJwq9i0Bv2UgpxTJY7zqdGnwAcDA1YqYcRBqWWGYWEUoJcXOBYRX6rwsbBn0
 JOBNzsdCEY4eOdYAYt2q8QbXdK7i/r+NlMQnbd1SiGKVELiXYis1tn9gG3FPwMNzxYMaitqy7
 dRwHQaA1WR/yppvKQEtj6U+Jeg14gVNm6aDnXTVPAvqJoqE1ssSAs7wZNlKoJ02NkOzSpX5/N
 3Wj4nkw6OgzLRUCu6BeMmrJWxw653iLyRh5WFQw3RQeL5KuE5m0KISElw2Yuwabw8yh7zqQfL
 5DTiGqZUgJtPqQWf0dLh1RttppKaolmu5vnh9gepIYWteFNf1MiNQ7dnDV5LsEEweDKUHFevu
 OYZmMVjq9oowS6YcSbflvGDFNc3P3x73upB9tjs+PFtUnXAGws122K0VSOyhnIy9I9Z0AAqKr
 QXa5/LY3O1auI0e+bmCeYSxeRgyVx2kMVnNSYW3KI6OSCqWYdSN3LWiEmCCpwN1oOwRhk86kg
 S9O7LTeaITFLqsbsBl6gc+hSxKZ70HFupGD/xRMQDd7oXOCKqr6LhCOeKpLviYBtodBZnuKY7
 HfL8F/3+q7SMPGGniu5zxCzanwrakkEwc2iI8yyUnj0iXI4ShDiaTjwY3WUUJdSpKV5sn/Kqy
 gUl+gjX73C7iKzg/dWSATOFDojQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Wed, 25 Jan 2023 11:05:06 -0600
schrieb Bjorn Helgaas <helgaas@kernel.org>:

> [+cc Salvatore, Mauro, Daniel, linux-media]
>
> On Thu, Jul 09, 2020 at 02:17:22PM -0500, Bjorn Helgaas wrote:
> > Bisected to Debian commit d2345d1231d8, which is a backport of the
> > upstream commit b88bf6c3b6ff ("PCI: Add boot interrupt quirk
> > mechanism for Xeon chipsets").
> >
> > Reporter confirmed that reverting the Debian backport from 4.19.132
> > fixes the problem.
> >
> > ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org
> > -----
> >
> > Date: Thu, 09 Jul 2020 15:01:11 +0000
> > From: bugzilla-daemon@bugzilla.kernel.org
> > To: bjorn@helgaas.com
> > Subject: [Bug 208507] New: BISECTED: i2c timeout loading module
> > ddbridge with commit d2345d1231d80ecbea5fb764eb43123440861462
> > Message-ID: <bug-208507-41252@https.bugzilla.kernel.org/>
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D208507
> >
> >             Bug ID: 208507
> >            Summary: BISECTED: i2c timeout loading module ddbridge
> > with commit d2345d1231d80ecbea5fb764eb43123440861462
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 4.19.132
> >           Hardware: x86-64
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: bernhard@turmann.eu
> >         Regression: Yes
> >
> > Created attachment 290179
> >   -->
> > https://bugzilla.kernel.org/attachment.cgi?id=3D290179&action=3Dedit
> > dmesg on 4.19.132
> >
> > OS: Debian 10.4 Buster
> > CPU: Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> > Hardware: Supermicro  Super Server
> > Mainboard: Supermicro X10SDV
> > DVB card: Digital Devices Cine S2 V7 Advanced DVB adapter
> >
> > Issue:
> > =3D=3D=3D=3D=3D
> > Loading kernel module ddbridge fails with i2c timeouts, see
> > attached dmesg. The dvb media adapter is unusable.
> > This happened after Linux kernel upgrade from 4.19.98-1+deb10u1 to
> > 4.19.118-2+deb10u1.
> >
> > A git bisect based on the Debian kernel repo on branch buster
> > identified as first bad commit:
> > [1fb0eb795661ab9e697c3a053b35aa4dc3b81165] Update to 4.19.116.
> >
> > Another git bisect based on upstream Linux kernel repo on branch
> > v4.19.y identified as first bad commit:
> > [d2345d1231d80ecbea5fb764eb43123440861462] PCI: Add boot interrupt
> > quirk mechanism for Xeon chipsets.
> >
> > Other affected Debian kernel version: 5.6.14+2~bpo10+1
> > I tested this version via buster-backports, because so far I was
> > unable to build my own kernel from 5.6.y or even 5.7.y.
> >
> > Workaround:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Reverting the mentioned commit
> > d2345d1231d80ecbea5fb764eb43123440861462 on top of 4.19.132 is
> > fixing the problem. Reverting the same commit on 4.19.118 or
> > 4.19.116 is also fixing the problem.
>
> Sorry, I dropped the ball on this.
>
> Berni has verified that this problem still exists in v6.1.4, and has
> attached current dmesg logs and lspci output.
>
> Sean's comment
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D208507#c18) suggests
> this is actually a ddbridge driver issue related to INTx emulation or
> MSI support.
>
> Berni confirmed that the i2c timeouts happen when
> CONFIG_DVB_DDBRIDGE_MSIENABLE is not enabled, and that enabling MSI
> via the "ddbridge.msi=3D1" module parameter avoids the i2c timeouts.
>
> The Kconfig help for DVB_DDBRIDGE_MSIENABLE:
>
>   Use PCI MSI (Message Signaled Interrupts) per default. Enabling this
>   might lead to I2C errors originating from the bridge in conjunction
>   with certain SATA controllers, requiring a reload of the ddbridge
>   module. MSI can still be disabled by passing msi=3D0 as option, as
>   this will just change the msi option default value.
>
> suggests that there may be an i2c or SATA issue that could be fixed so
> ddbridge MSI could be always enabled.  But I don't know about that
> underlying issue.
>
> Per MAINTAINERS, the ddbridge driver looks orphaned, so I cc'd the
> media folks and Daniel, who might know something about the MSI issues,
> based on adaf4df70521 ("media: ddbridge: Kconfig option to control the
> MSI modparam default").

Bjorn/all,

I'll try to at least clarify from what I remember from "back then",
since it's over 4,5 years that I last actively worked on mainlining the
vendor driver and not being affiliated with the vendor at all.

MSI being defaulted to disabled with the possibility to try
ddbridge.msi=3D1 is the result of quite a bit of user feedback mainly at
vdr-portal.de, recommendations from the vendor itself in case of I2C
troubles with their cards, plus an explanation from them (been in
contact with the vendor at that time) telling me that "some"
PCIe/chipsets are buggy especially with regards to MSI and thus can
cause trouble with their cards. Also, in addition, I experienced I2C
troubles with ddbridge.msi=3D1 myself so I decided to make the default
"0" (with an option to toggle the default marked as "dangerous" due to
the known possible issues) as this worked the best for everyone who
opted for testing the mainlined driver code. Due to lack of real
knowledge about chipsets, PCIe, interrupts and so on, and lack of
technical docs about the cards, we could only assume we're dealing with
some sort of incompatibility between the cards and possibly certain
components, though ddbridge.msi=3D0 made everything play nicely with each
other.

Regarding #208507, I see that there are chipsets and/or platforms that
either soft-disable legacy IRQ signalling/routing (via the
mentioned/reverted/bisected commit), or even don't support this at all
and thus make MSI a requirement, and causing interrupts not being
serviced at all if MSI isn't available or enabled by the device.

If it is possible to query the underlying subsystems regarding
availability of legacy interrupt signalling, I guess the best option is
to perform such evaluation in the ddbridge driver during setup and
enable MSI signalling if that's the only option regardless of
ddbridge.msi=3Dx, what seems safe on such platforms according to the
reporter (card running fine with msi=3D1).

I'll happily provide patches for such a change though I would very
welcome any guidance on the subsystem query topic.

Best regards,
Daniel
