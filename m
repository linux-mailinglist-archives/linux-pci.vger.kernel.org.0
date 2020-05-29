Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66DA1E7585
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 07:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2Fpx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 01:45:53 -0400
Received: from mout.web.de ([212.227.15.3]:58433 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgE2Fpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 01:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590731139;
        bh=sjCtEFzZ5Xk+2jMsjk3i83yv7YIJPotpPQD6rKcpc0E=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=ISUXv1KSVs5YDwozCm70TLiQ7f2zcwPsw8peZwwy1z5wt8wZtONV+DdGtMen1ZND1
         kMCA8eYRTdfrZaqv2AOufzBp6YfKJA6uVRfH9fhsn4R1QlsLz4A3l9kU+PPtKIyfWp
         PuKI0NhMHqBqHFLa2Herr1PWU4VWMb3EqWmw7huQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.188.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3US-1ingAN1qjI-00qwy1; Fri, 29
 May 2020 07:45:39 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Chiang <achiang@hp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCI: Fix reference count leak in pci_create_slot()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Qiushi Wu <wu000273@umn.edu>, linux-pci@vger.kernel.org
Message-ID: <4cf93f73-5bea-9748-f97b-99a6efe9ea20@web.de>
Date:   Fri, 29 May 2020 07:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QG4m24v4tia6C2u5PBjoiLZBrlLZ3jP3y/bJnHLWSZICR+PjIqv
 AKU13+vOktVCRVN6HamkoLqLTvxkmghdXYPf137IuzH+fyo7MkoMHyi/3ssqCc30PDo9hZc
 9kgbZNKvlF99Y9N3gUNhS3u0ergWFFit3hOiH5yo8/6o5hARYpyh843meBFgCmd9raZCTcj
 ++kc9HEnuZzT64DL7oykA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pLgsO9uIE3c=:xx7lWoDVpGKDaUcGnn+tNf
 VwSAi6FRkA/2/FY3TpKNapGaCDciMsCj6JWftZp5qSSeUYMYBX7kzS3+indi7IujFhq0reApG
 jGC28SkSbX0tatu/Wq26sfL7+a4bIeYqzFd7bh6vfDrftlTDejjjuAeU4DgwOmugGSyLUCszi
 PisEVC4FUHD+nBvGKm+rwzyzFAEd/TM0A/0VCBBJlUrp9JuAYb7sx1GXHc4/G+6tIBk2l7jHb
 oisFmrETVVNgGmVqwz1+9yRq+t65QWLa2nCLoVKUUqWhANsP5+Lmqhh4wALXdrtzvincGpHBd
 A0lCz2b33e6HEq0HsXFGQnscdjPh+GGVp4YGTZYXnRQf7eJKT5JVaa9iJTY83uLHfmeG3k4Di
 pAOtLgCMa1vF7FiBXUdr5XY3PifjFDiAlpLeIfMPggruMnHAwClQkKhnk6ZDpwlXKTNvgbM1g
 1mhzf2Tyl9t076wmTxkoa2P6eCjLIOhk5NtA9gQMik+lw+U1ZJsZVGXxgwYo7dVhK4LREuhb1
 oKZ0KyiMfCNN/aZMax0nZaaj/Oel4+uhKNmvdEeGGaQ9/ij+OhtKxIReDmeTvURkSZUAADcEZ
 qd/6qzaGrBhn0AzNCbopszBAF4YIMElII9w8LdBV2xuc7UsmQMFedRLlip0pvmDP98qwaL36/
 J7uDyobzsMydF6tmkS09Z5Tn4TFhQzx2O66zDD9KaaKLLlUxiSIVsyYAf/Fo5DKwhg66RhIue
 HHunU12I5dH0zWQYMb5HKwNSBVOOweCv+ZVtFLuMQv5urGLfIIGQSD/snSrMLeLfqEpoZIyFg
 7V4+oKBGJkrlS1e9MIasUT3iHtPXQ+VpDSzpv+uXOahjwCz7Dx9fwYDE3Wpoh1Xw6HaWb417y
 ZB/+Xmm86v09xyAGa7gF2fRvbmi1MHdSAELaDK2bxm6MEifEBa33dkxa9AKdGhLMSRBYAe385
 H3Eftfh31zfKllZzIkRTsai/F5QPJ6L5MScn04CpcfLIuwGHC+TFx7CyUJ231IJaBFTM/Xx2/
 Yaz+0Uljfesr5UeasM8wqK9HYukU0hmCqf7RYyVg6CXfaLbJcELMif//hSjxrtberD6n+VBU+
 RImWw9Nk9/XRlVT5dwx2tC2uxgWc63T2WRWh6KcPa81uqvubShFZK0JPToGKpDunDm90/o7sr
 9misiBkzZgt1nBpxgKZ+OWP/CFajyRUoBF6aSs/qEhhuRdJbXszJmBIcNawBVaDMOovt6gCgf
 NgJ4T3aEKgneddCWH
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please add a prefix to the patch subject.


> kobject_init_and_add() takes reference even when it fails.

I suggest to extend this description another bit.
Which object is affected here?


> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object.

Such a copy from the function description of this programming interface
can be helpful.


> Thus, when call of kobject_init_and_add() fail,

I propose to avoid the repetition of this condition.


> we should call kobject_put() instead of kfree().

How do you think about a wording variant like the following?

   Replace a call of the function =E2=80=9Ckfree=E2=80=9D by =E2=80=9Ckobj=
ect_put=E2=80=9D
   because of using kernel objects in the proper way.


> Previous commit "b8eb718348b8" fixed a similar problem.

I wonder if such information is really relevant for the commit message.

Regards,
Markus
