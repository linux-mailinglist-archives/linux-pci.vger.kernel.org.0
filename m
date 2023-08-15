Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4277CE5F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbjHOOpx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbjHOOpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 10:45:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292BC5
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 07:45:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so81190301fa.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692110730; x=1692715530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3mGtE6mLU4USg1aVsDvMou0yVohV6fopLYmyTlcoqw=;
        b=Nch6UiDeIkIqthdUzrwmap2//5jDMCFV6dzoKF3RFOvKC+Ksa+cQL/CVeVptTzmd06
         dHd8xZtbE5wUPbtLClREM8inXxE08NSngxW0Snaiea6lHNbpz6MtuGtR6Q8AlkRtq/cu
         yyBELVxE4jdXqv7cI7oYW2+uEMQ/nnSIBYMGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110730; x=1692715530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3mGtE6mLU4USg1aVsDvMou0yVohV6fopLYmyTlcoqw=;
        b=Z3C/B5QJXz44fE4dVN/QnODvbRiWOP0Tw9WMxZgNcE/OMLp4lwmqNXQNqKxGfRSLWk
         GHNrwRf/uLCtuwmophr8kVAJQT13oj73wSH65B6Vrju5xQfAIffMs3ojP08VFhOegBRe
         8zI7nFmj7SpV84E0nVcPKHIKmr1Sz6TRmH6l9bvZ54KmJrnEZk2mlmDacaO7qguBl3k1
         Lv7RgCNi/3HcPwQGFvDNCDnF+wBgJFn7+ALnBTWQ8tt4u5u+9A7cKzIlPscoGH3XemiT
         CREvAwVa4MMZZxiMq0TUMaGt05m5tFtmLwRKLuoV/IzCd1AgukugSz1gk8bXgv29Kx7K
         Y/mg==
X-Gm-Message-State: AOJu0Yzb2RgocVnNY3nemy3k4/FQoODnoFts/hpabAjTOBCxo0x8qCjf
        Q9sFYXc7APY7P29r5xuI0QMnWS87IsNRD5BGKyy9
X-Google-Smtp-Source: AGHT+IFVXUl5Cl8/LtmxkcpdBq+bk3HP85F80kwNqm9hehPAHORMvnTx5AoOutEVbJ42bB3r1np39Cr+n6Nd+e5o+SY=
X-Received: by 2002:a2e:7015:0:b0:2b9:b27c:f727 with SMTP id
 l21-20020a2e7015000000b002b9b27cf727mr8864730ljc.8.1692110729736; Tue, 15 Aug
 2023 07:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <uba6vj$10n6$1@ciao.gmane.io> <20230814162028.GA176555@bhelgaas> <ubedo7$151n$1@ciao.gmane.io>
In-Reply-To: <ubedo7$151n$1@ciao.gmane.io>
From:   Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date:   Tue, 15 Aug 2023 08:45:13 -0600
Message-ID: <CAFdVvOz9=wuxeH6nUkmSMRe0vxDRL-b62aaLg_4uaXWD9kK8cA@mail.gmail.com>
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT SAS
To:     emanoil.kotsev@deloptes.org
Cc:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fd0ce30602f73a75"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000fd0ce30602f73a75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This has nothing to do with the driver and would require analysis from
the controller hardware/firmware perspective.  The 1068 chip is pretty
old and out of support and it will be difficult to get any analysis
done on that.  If you want to upgrade, the latest 12G SAS-NVMe Tri
Mode controllers are better from a long term support perspective.
https://www.broadcom.com/products/storage/host-bus-adapters.

Thanks.


On Tue, Aug 15, 2023 at 3:41=E2=80=AFAM deloptes <emanoil.kotsev@deloptes.o=
rg> wrote:
>
> Bjorn Helgaas wrote:
>
> > I don't know why that would be.  Are there any hints in the dmesg log?
> > Can you collect the complete dmesg log with the old drives and again
> > with the new SSDs so we can compare them?  I assume you have good
> > cables?  I assume the same cables worked at 3.0 Gb/s with the old
> > drives.
> >
> > I would *expect* that SATA r3.3 would be completely backwards
> > compatible, so since mptsas worked just fine at 3.0 Gb/s with the old
> > SATA r3.0 drives, it should also work just fine at 3.0 Gb/s with the
> > new SATA r3.3 drives.  But I have no actual knowledge about that.
>
> Thank you for your answer. I am also confused and couldn't think of any
> meaningful reason. This is why I allowed myself to bother you.
>
> I did not change anything - wiring or such. The server has 12 disk bays o=
n
> the front. Old disks were pulled out and new disks were inserted into the
> bays.
>
> You (probably much knowable in this matters than me) also assume negotiat=
ion
> should result in 3.0Gb/s. And if I understand correctly it should be not =
a
> driver issue.
>
> The only difference I could find out for now is that Rev3.3 introduced PW=
DIS
> on Pin 3. To check if the cables provide wiring on P3 I should disassembl=
e
> the server, but I can do this in September :/ and it is a lot of effort.
>
> I am attaching a portion of the log and dmesg with the relevant informati=
on.
> I see that ASPM is disabled by default (could it be related to P3?).
>
> Thank you all in advance
> BR
>
> --
> FCD6 3719 0FFB F1BF 38EA 4727 5348 5F1F DCFE BCB0

--000000000000fd0ce30602f73a75
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
v82E+npLwqC8bSHh1m6BJewfpawx72uKM9aFs6SVpLPtN6a5369OCwVeEwkk2FeFU9tZXWBnI4Wu
d1Q4a3vhOColD6PdTWv74Ez2I3ahCkmpeEQ1YMt61TUH3W8NUJJeYN2xkR6OGsA1AgMBAAGjggHc
MIIB2DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRw
Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJz
b25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRC
MEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3JsMCYGA1UdEQQfMB2BG3NhdGh5YS5wcmFrYXNoQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
VyBc/F5XGkYNCP9Rb96mru8lU4AwDQYJKoZIhvcNAQELBQADggEBACiysbqj0ggjcc9uzOpBkt1Q
nGtvHhd9pbNmshJRUoNL11pQEzupSsUkDoAa6hPrOaJVobIO+yC84D4GXQc13Jk0QZQhRJJRYLwk
vdq704JPh4ULIwofTWqwsiZ1OvINzX9h9KEw/+h+Mc3YUCO7tvKBGLJTUaUhrjxyjLQdEK1Xp/8B
kYd5quZssxYPJ3nl37Moy/U9ZM2F0Ivv4U3wyP5y5cdmBUBAGOd94rH60fVDVogEo5F9gXrZhT/4
jKzCG3LclOOzLinCkK2J5GYngIUHSmnqk909QPG6jkx5RJWwkpTzm+AAVbJ9a+1F/8iR3FiDddEK
8wQJuWG84jqd/9wxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgx2rp2oPFt1hdtt8l8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO2awsWX
OfBqRcNCxmPCgKY1Y12fXlsVv6dA9CxFLRbAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDgxNTE0NDUzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBjb/1bpbS6UajrhoBC3tBlAfNu
0kHhvOC3/dRAQNdu10xyhafRHFUSiA4y8Zc/MAlqFVamIZmYVSF5f5oUi+r8QXRauLFHw9ducH6l
BaHOt+Q6YAjvWANlQUjSgT9ObhAVUI0GRMUXqVMDTFiLcPpQaqzm4qFWCVSh7ryELh2PW7oLoMpm
iiUY5q4Zoy06SJh9R0msfpiuqf1Y515O5aLgy1iaMyQG71/YKuD+SGR6Uv7SCdKAgWhZpFWsQVM0
+hDTbW4f5sK7AAtICGyvu4LpB7qtzaFf6SQh0s7nfIER4d/0ov/ZlzlCla3+ZORgshUgOd3c1W9n
EprrzXsxKgKM
--000000000000fd0ce30602f73a75--
