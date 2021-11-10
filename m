Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B397044BAB8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 04:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKJDzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 22:55:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64730 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhKJDzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 22:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636516334; x=1668052334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DuAMezrT6YElGWjfcaouVYsLWg9EC32l6gp1Eic4vso=;
  b=GXAcgPzU3Jv8Jd/Vrq1tUy6fYI/cXwGdGkWfNUmfHnsp1PEHC1O6BofM
   0QEI+QCj7xIAk9f3dce8yopTXumg99KoJaPTeGT8esSOIZ4nxpGSx6IkL
   verBYQgjm9QZeQyo3TCt0Pd9+mPhx1hxlTFGY8B8eahaLLkjhA7sJJ2iT
   R4yh9yzVKAoF3PqnSZt0ZXmMb24hGF6wJhSLCZFV+Epc1jfIocj4k8XhY
   CY/xLoYsGAcs7VaoThy48YCaDiD6DFCpF3T0JUEVS6+ZnUN8c2+opMiJt
   VRc5BEVCuyRsPxiIT22qLiFQa/4bFIMYlGTQAEH/3hWucc9wEIcGvB0iR
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,222,1631548800"; 
   d="scan'208";a="189995488"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2021 11:52:14 +0800
IronPort-SDR: Ntgqo1E4EyA3XDojVCculP7CWxkMlKZGvzm4vwEyQSIy/FmgouSGXSL5ypWaj0QAgRrlFZBkKy
 J82/nYCLIMxpeyCXCDYB0ur8lfsGKCpnhHDF/aBYsMz+lOHscuHloGDJYWuqe9vpFGiyWXXe7U
 179jZsg+8+qwFbV4goODMHAjjjx1b2JiRtxZHTvsJyjRla1ZJ3hZ6dkQaPZerAx0eDXUmJ24ni
 dVNZPAV3Qk+0cI8u8OHfuZsz9fwv92zfXqT9unuJDSze88g5ppTthPle8IU6zbee1QE3SfD1qH
 MuVA94RlfT06rUtKkQ84paxz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 19:25:55 -0800
IronPort-SDR: qeJvyJO6dsdbSWE1jK8+kqaeL4KniOX0wSdG9P1gsd+RKdkIxgNMB9xDXIMw558vr7RCUTvMKY
 4/tGSsIDlmfY1f6W5NTs5m2Yb2ZfOiyjwW686SXF18yQvradwOtRZXgbt8LmOfIjMd6lZz/eL/
 cBbHeymihUp1uhHTxV3MoIwOYM4IcdoRy7m6fu7bFHiWkWi2UCbn2MrrEbHKabE3ukCaLaZJDu
 ytllXC/XGR9R0rU9TLhGiaV3Dnu8UGWfhY5VTrJWY39ZBSFch8NPeWg6m9NQRe0kBd+BXCRy1p
 Ha8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 19:52:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HprWz6tQDz1RtVy
        for <linux-pci@vger.kernel.org>; Tue,  9 Nov 2021 19:52:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636516334; x=1639108335; bh=DuAMezrT6YElGWjfcaouVYsLWg9EC32l6gp
        1Eic4vso=; b=VALxo1hS5Q5g4pBmf+fm2P5oB7pmVEqjwbq75a+u6PC6yI0LqH1
        yM0bFrRcOKKvoZx/rTc2OlBtKzCbC7UCauzD7tnz+4Lzu6Xmtg/GU1yWFvPGARlG
        KYP+tmo2Zxd/wug3Pna4HWgR5aB8I2v9D0x2+EvRKiSgujVlfcIZiR1k8ELLRCsw
        ix237ij9XKuiBS1HC8twqU0kN1wRscNJmkUqQtYaP4ImLoYpIbzFBk/ETZxvhVIZ
        0QFBI86vY0iGD/CJqrCCVZniD1YPYsyf5A6bpauoFkMJOFihSzSjwG9Y2CzDMUEe
        5qli89V3s+1Oknf/VmuxXYYun3TUbriN6xQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pIxU_hHE9PSZ for <linux-pci@vger.kernel.org>;
        Tue,  9 Nov 2021 19:52:14 -0800 (PST)
Received: from [10.89.81.216] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.216])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HprWw57j3z1RtVl;
        Tue,  9 Nov 2021 19:52:12 -0800 (PST)
Message-ID: <1400f0f2-9247-6540-2685-be257d9ef243@opensource.wdc.com>
Date:   Wed, 10 Nov 2021 12:52:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Matthew Leaman <matthew@a-eon.biz>,
        Christian Zigotzky <info@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>
References: <ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de>
 <20211109165848.GA1155989@bhelgaas> <YYr4x1xWfptXRmqt@rocinante>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YYr4x1xWfptXRmqt@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/11/10 7:40, Krzysztof Wilczy=C5=84ski wrote:
> [+CC Adding Jens and Damien to get their opinion about the problem at h=
and]
>=20
> Hello Jens and Damien,
>=20
> Sorry to bother both of you, but we are having a problem that most
> definitely requires someone with an extensive expertise in storage,
> as per the quoted message from Christian below:
>=20
>>>> The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.1=
6
>>>> updates [2].
>>>>
>>>> Error messages:
>>>>
>>>> ata4.00: gc timeout cmd 0xec
>>>> ata4.00: failed to IDENTIFY (I/O error, error_mask=3D0x4)
>>>> ata1.00: gc timeout cmd 0xec
>>>> ata1.00: failed to IDENTIFY (I/O error, error_mask=3D0x4)
>>>> ata3.00: gc timeout cmd 0xec
>>>> ata3.00: failed to IDENTIFY (I/O error, error_mask=3D0x4)

IDENTIFY is the first command sent to a device when it is being probed. T=
his
means that at least the AHCI (is it AHCI ?) adapter found the ports and d=
rives
connected. But the qc timeout indicates that there is no response from th=
e
drive. This could be due to interrupts not being received for the command
completion. One thing to try would be to increase the identify command ti=
meout
to see things simply got slow (for whatever reason) or if indeed there is=
 no
response at all. Note that after the first timeout, normally the port is =
reset
and the command retried. That does not seem to be the case here. Weird...

Maybe try something like this:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1d4a6f1e88cd..16e105bcb899 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -79,7 +79,7 @@ enum {
  * take an exceptionally long time to recover from reset.
  */
 static const unsigned long ata_eh_reset_timeouts[] =3D {
-       10000,  /* most drives spin up by 10sec */
+       30000,  /* most drives spin up by 10sec */
        10000,  /* > 99% working drives spin up before 20sec */
        35000,  /* give > 30 secs of idleness for outlier devices */
         5000,  /* and sweet one last chance */

Also note that I posted a patch a couple of days ago fixing a qc timeout =
for
read log commands during device probe. This is not what you are hitting h=
ere
though. I have not yet sent this to Linus.

https://lore.kernel.org/linux-ide/20211105073106.422623-1-damien.lemoal@o=
pensource.wdc.com/



>=20
> The error message is also not very detailed and we aren't really sure w=
hat
> the issue coming from the PCI sub-system might be causing or leading to
> this.
>=20
>>>>
>>>> I was able to revert the new pci-v5.16 updates [2]. After a new comp=
iling,
>>>> the kernel recognize all ATA disks correctly.
>>>>
>>>> Could you please check the pci-v5.16 updates [2]?
>>>>
>>>> Please find attached the kernel config.
>>>>
>>>> Thanks,
>>>> Christian
>>>>
>>>> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3D0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
>>
>> Sorry for the breakage, and thank you very much for the report.  Can
>> you please collect the complete dmesg logs before and after the
>> pci-v5.16 changes and the "sudo lspci -vv" output from before the
>> changes?
>>
>> You can attach them at https://bugzilla.kernel.org if you don't have
>> a better place to put them.
>>
>> You could attach the kernel config there, too, since it didn't make it
>> to the mailing list (vger may discard them -- see
>> http://vger.kernel.org/majordomo-info.html).
>=20
> Bjorn and I looked at which commits that went with a recent Pull Reques=
t
> from us might be causing this, but we are a little bit at loss, and wer=
e
> hoping that you could give us a hand in troubleshooting this.
>=20
> Thank you in advance!
>=20
> 	Krzysztof
>=20
>=20


--=20
Damien Le Moal
Western Digital Research
