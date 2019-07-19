Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097696E48A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfGSKvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 06:51:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:64239 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfGSKvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jul 2019 06:51:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 03:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="asc'?scan'208";a="162372763"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2019 03:51:18 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Lin <kent.lin@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Subject: Re: Titan Ridge xHCI may stop to working after re-plugging the dock
In-Reply-To: <77580193-D67B-48B1-8528-03ED4E7E8D64@canonical.com>
References: <993E78A1-2A60-46D8-AA51-F4CB077E48D1@canonical.com> <1562759399.5312.6.camel@suse.com> <87pnm6sd10.fsf@linux.intel.com> <77580193-D67B-48B1-8528-03ED4E7E8D64@canonical.com>
Date:   Fri, 19 Jul 2019 13:51:14 +0300
Message-ID: <87blxqs3fh.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Kai Heng Feng <kai.heng.feng@canonical.com> writes:
>> Oliver Neukum <oneukum@suse.com> writes:
>>> Am Dienstag, den 09.07.2019, 21:10 +0800 schrieb Kai-Heng Feng:
>>>> Hi Mika and Mathias,
>>>>
>>>> I=E2=80=99ve filed a bug [1] which renders docking station unusable.
>>>>
>>>> I am not sure it's a bug in PCI, Thunderbolt or xHCI so raise the issu=
e=20=20
>>>> to
>>>> you both.
>>>>
>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D203885
>>>>
>>>> Kai-Heng
>>>
>>> The issue starts before you unplug. In fact it starts before
>>> the dock is even detected the first time:
>>>
>>> [   13.171167] rfkill: input handler disabled
>>> [   19.781905] pcieport 0000:00:1c.0: PME: Spurious native interrupt!
>>> [   19.781909] pcieport 0000:00:1c.0: PME: Spurious native interrupt!
>>> [   20.109251] usb 4-1: new SuperSpeedPlus Gen 2 USB device number 2=20=
=20
>>> using xhci_hcd
>>> [   20.136000] usb 4-1: New USB device found, idVendor=3D0bda,=20=20
>>> idProduct=3D0487, bcdDevice=3D 1.47
>>> [   20.136004] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2,=
=20=20
>>> SerialNumber=3D0
>>> [   20.136007] usb 4-1: Product: Dell dock
>>> [   20.136009] usb 4-1: Manufacturer: Dell Inc.
>>> [   20.140607] hub 4-1:1.0: USB hub found
>>> [   20.141004] hub 4-1:1.0: 4 ports detected
>>> [   20.253025] usb 1-4: new high-speed USB device number 5 using xhci_h=
cd
>>> [   20.403520] usb 1-4: New USB device found, idVendor=3D0bda,=20=20
>>> idProduct=3D5487, bcdDevice=3D 1.47
>>> [   20.403521] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2,=
=20=20
>>> SerialNumber=3D0
>>> [   20.403522] usb 1-4: Product: Dell dock
>>> [   20.403522] usb 1-4: Manufacturer: Dell Inc.
>>> [   20.404348] hub 1-4:1.0: USB hub found
>>>
>>> This looks like a PCI issue.
>>> In general, this kind of reporting sucks. We have to guess what you did=
=20=20
>>> at 19.781905
>>
>> It might be nice to know which device is generating that and why it's
>> not found. This may help:
>>
>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>> index f38e6c19dd50..33285ef29362 100644
>> --- a/drivers/pci/pcie/pme.c
>> +++ b/drivers/pci/pcie/pme.c
>> @@ -203,7 +203,7 @@ static void pcie_pme_handle_request(struct pci_dev=
=20=20
>> *port, u16 req_id)
>>
>>   out:
>>  	if (!found)
>> -		pci_info(port, "Spurious native interrupt!\n");
>> +		pci_info(port, "Spurious native interrupt! (Bus# %d DevFn=20=20
>> %d)\n", busnr, devfn);
>>  }
>>
>>  /**
>>
>>
>> Also, according to what Kai-Heng said, xHCI stops working even after
>> repluggin the Dock. We could be dealing with two bugs here:
>>
>> 1. Spurious PME event being generated by an unexistent device
>> 2. xHCI not handling hot-plug very well
>>
>> Kai-Heng,
>>
>> please run your tests again and make note of when you unplugged the dock
>> and when you replugged it so we can correlate the time stampts with what
>> you have done otherwise we will never be able to pin-point what's going
>> on.
>
> I upgraded the system firmware, TBT firmware and docking station firmware=
=20=20
> to latest, and used latest mainline kernel.
> Now the issue can be reproduced at the very first time I plugged the=20=20
> docking station.
>
> Attach dmesg to BKO since there are lots of message after XHCI dyndbg is=
=20=20
> enabled.

I saw that you annotated the plug, but not the unplug. Where does the
unplug start? There are many places where it could be, but I need to be
sure.

Also, wasn't it so that the problem is when you *replug* the dock? So
can you better describe what you're doing? Are you booting with dock
connected then disconnect and reconnect or are you booting without dock
and it fails on first plug?

What are you consider a fail here? Can't you see the xhci bus? USB
Devices don't show? What do you have on lsusb -t?

Best regards

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0xoKIACgkQzL64meEa
mQZmig//RAfJB8uUCkf0MCxqZeaQRIWfaPJVUKdDyGpdtXuhvWv7ZP4ldoSoRCXg
lKsp3NmnaJFlDOcGQaH/ga0hAzJDPfqCDWvYBIug0FY82OuRcSE0jqHVjIo2SDhu
76zex6Qp43VPP8q5KLZmwTWe1O9uSJBf6QqFY9AXv2Sf9eCmrzTgRBTrCPrJUoSt
SVt4TcAHFFf2YjBLGRo5POOu9CKBS8NmDFAIjTyZNcF1HSo6yiYUi59FLvoEH7AU
xFlZxy/ZyYHFnH3UK5BehO9ehzm7mA22QAXaCcBLjBrIJYOKGiroxiXozaMZk2n7
G0k6KeGYB+17H+4dEXW0sj53hEukltGXKlfKeQ25wv6+p8Dl9TqQWgqbgVyDw9AL
r4CxEyqX9Z0J/lUeL9SQZX4n+dm6WMIZ9PE5p+ksJ8WRjBXtTkSvo9D48v9TbugE
5IhkU4qkM9XBHU/61VgBpCHUpT0GQ2+VR9ptoByiwU7y5Glb0mr1/ycM0Qd7+rUb
4sYx4Q26PpOStDq6Nv+PC2AfIfR39Q5rKGzmf8/yWllWbBfW6nRGfKowcwBirlDO
KtPKJnskXfUCUlhCV/6CikzdrLFj/jG/HE3o2L4LQSDqTPsXbI8ZWgKiXpYwYsMe
4aQWP9mljwr5z4LIJjGV/zlXR2EbjGuLN9LpeGO0y33tMiBwgCo=
=vCgm
-----END PGP SIGNATURE-----
--=-=-=--
