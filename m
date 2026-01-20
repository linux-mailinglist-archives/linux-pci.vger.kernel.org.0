Return-Path: <linux-pci+bounces-45257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA9D3C572
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 11:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B342C5A9AE1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A693EDAA4;
	Tue, 20 Jan 2026 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dzsgeInW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F3D6479;
	Tue, 20 Jan 2026 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904911; cv=none; b=nkHpiVlsiQT2Po4/1EWSxIdvR1rO4KMM75nSa5nA4H+kSyWuZLix4kiwk9sW0O/sre+lf+HNeV3QXDuB3/df/4K3NK8W3Isz9ZrPBNx6PTZYp0KoMWT8/El5LdnZXAfYPdPwnZvxn5gzUY1rKLItW84Cl5KMn+P6sUk8ewZIn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904911; c=relaxed/simple;
	bh=o2YEmidTzHei1Gch3ATR/a8V9bGaTg6F2uv6s1c518I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S12CuS9k+Q4bZjYErjSmq4aeJ6iY1qgQwmYZwQJGw2eqnpnhu943gvcGul0WHbCzbWoB1NtmSzR4mIqnOR2N0OoWT2nHzTiXxJL2Ik3ZMdCHrG7GIwiUfD+oIY0WPzRDCFoRXt43HjNdVu/RZZ4ohuYLjM+FmwM51a8w3PEJeVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dzsgeInW; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768904828; x=1769509628; i=spasswolf@web.de;
	bh=CyHSeQ3UJv8sOqLdcbVinP5LB8wxqbnzWWo7pzqgzmk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dzsgeInWbuZNx/dGDZRWvJVtdut+8pIUTjmGXehCiN9H6Qkya9gPC2pD9+h6b8K3
	 sf2+PjceXwZZ1suiw30QnttMyXVCA+rWHUtIcHQfdrlmSaWcHwIbu5ojHoNaRMpOa
	 W2CLLOAWM7YMOrQ7oSqYiwQ99oi/dGBd1YZkyNsc+gFld4bDKOE7U7/HnQ+mAvHlX
	 ExEQPuDXlI4AGnD+9Oz6QkN0x390Oqs6D42x/6z7xE/pHxx+1cinHXhJdtYt4PtFc
	 z3rVNmxnqTs0KMNjNkRxzrxgaxtoIGsasLIUxssOfFZdo29dokhXEIzOBVd9h923b
	 Z4oqbGhV8kBLMPCTpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1vmWfD3elc-00D6gh; Tue, 20
 Jan 2026 11:27:08 +0100
Message-ID: <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
Subject: Re: crash during resume of PCIe bridge in v5.17 (v5.16 works)
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, spasswolf@web.de, Mario Limonciello	
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore	
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang	 <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker	 <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong"	 <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson	 <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,  Joanthan
 Cameron <Jonathan.Cameron@huawei.com>, Joel Granados
 <joel.granados@kernel.org>, John Ogness	 <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, Li Huafei	 <lihuafei1@huawei.com>, "Luck, Tony"
 <tony.luck@intel.com>, Luo Gengkun	 <luogengkun@huaweicloud.com>, Max
 Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek	 <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>, Sergey Senozhatsky	
 <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo	
 <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, Thorsten Blum	
 <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton	 <akpm@linux-foundation.org>, W_Armin@gmx.de
Date: Tue, 20 Jan 2026 11:27:00 +0100
In-Reply-To: <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
		 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
		 <87v7h5ia3d.ffs@tglx>
	 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AMDbhLUWL5uuhXDdpMs4FD7yyH9DuhuguVKE3b9hux84CaHgoxh
 FDlZuudUAzc62+WF+PS65clDkdyylrG9S9EbY/zaSd5JHSiG8ksbGN3FMyaSCoxovcwtVF4
 0wLxfW6ayTIvW2v+IfMZDh2ed/EPbky2krTwgxJi5p7NImlOz0drfO9yk7mngELFErL5ZEm
 56r7D7FtCwzI+23dTbwCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cAJtVuTQ8/k=;VCLD6sMgAgJ0VhQqVyNcoZurWmg
 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
 /1hApXIQ=

There are exitining news here:
I tested older linux versions with this script

#!/bin/bash
for i in {0..20000}
do
	echo $i
	evolution &
	sleep 5
	killall evolution
	sleep 5
done

with the following results:
Version v5.17, v6.1 and v6.8 show more or less the same
behaviour as v6.12+, i.e. repreated resumes crash after a=20
while (sometimes the discrete GPU is lost without a crash)

Version v5.15 shows a different behaviour:
5.15.0-stable-dirty			booted 14:28, 16.1.2026 error 14:52 (25min, 142 resu=
mes)
[ 1453.515962] [  T18093] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc=
 hw!
[ 1453.515978] [  T18093] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *E=
RROR* resume of IP block <smu> failed -62
[ 1453.516046] [  T18093] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-62). (-ETIME!)
5.15.0-stable-dirty			booted 17:09, 16.1.2026 error 20:18 (3h, 1102 resume=
s)
[11337.547257] [ T157373] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc=
 hw!
[11337.547273] [ T157373] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *E=
RROR* resume of IP block <smu> failed -62
[11337.547358] [ T157373] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-62).
5.15.0-stable-dirty			booted 20:51, 16.1.2026 error 21:20 (30min, 164 resu=
mes)
[ 1698.065653] [  T22129] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc=
 hw!
[ 1698.065665] [  T22129] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *E=
RROR* resume of IP block <smu> failed -62
[ 1698.065734] [  T22129] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-62).
5.15.0-stable-dirty			booted 21:25, 16.1.2026 error 21:41 (10min, 91 resum=
es)
[  965.908197] [   T3843] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc=
 hw!
[  965.908212] [   T3843] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *E=
RROR* resume of IP block <smu> failed -62
[  965.908284] [   T3843] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-62).
5.15.0-stable-dirty			booted 21:46, 16.1.2026 error 1:43 17.1.2026 (4h, 14=
11 resumes)
[14220.044577] [ T203585] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc=
 hw!
[14220.044593] [ T203585] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *E=
RROR* resume of IP block <smu> failed -62
[14220.044662] [ T203585] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_re=
sume failed (-62).

In all 5 tests the resume failed, but with an error message not seen befor=
e, also no crash occured.

And most importantly v5.16 did not crash at all, and also did not show any=
 GPU suspend/resume related error
despite being tested for 36h and 11644 resumes:
Testing (dirty because of -Wno-error=3Duse-after-free and -Wno-error=3Dfor=
mat-truncation compile fix)
5.16.0-stable-dirty			booted 2:09, 17.1.2026 14:20, 18.1.2026 no error (ne=
ither crash or loss of device)
					(36h, 11644 resumes)

So the whole issue seems to be a pure software issue after all (not just a=
n issue related to
probably broken hardware). I'm currently bisecting this between v5.16 and =
v5.17, but getting a
result can take 2 weeks given the length of the testruns.

The first step of the bisection is already finished and GOOD:
Testing (dirty because of -Wno-error=3Duse-after-free and -Wno-error=3Dfor=
mat-truncation compile fix)
5.16.0-bisect-07203-g22ef12195e13-dirty booted 14:27, 18.1.2026 no error 1=
:57 (35.5h, 12508 resumes)

Bert Karwatzki



