Return-Path: <linux-pci+bounces-27183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DDAA9ADA
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05817A3C19
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBEEEC3;
	Mon,  5 May 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZwkWVYOa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68A1865E3
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466796; cv=none; b=GTPvJAXcZG0PS7A4pAxFkQQ5OOrXMB7v2/Fdloejvd/wFCA0g+4eRtbs+hu7IxXyqB7gBnTao+IEqNRPjsMEgdRJlyiU8aLN7G8O0gYiTbI7WIo94aifePxr4nf03pftJEqtMZLw516w8NudvbfVteI/uPEQ0e6nV0qt9rHn5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466796; c=relaxed/simple;
	bh=pk7fjig4z1eaVvdvtHStuMQDhqm0BWu89MO+wSV2bw4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=H/BTK3XmVT7HTHSiYWFRuvM0ZeVbMqYAAIzNJox5pAbdMXfN81dGAddI1lG/DOtO+hKzpcLA7aG3sU5tryc5zsWPL6G6+Xq3yi9nQsmofBg5pGdBQOCeNOiKoyFHI334vNDnggcVX3Bd7IGIGr8gxDtmcRBm3+ReI55z+L923No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZwkWVYOa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso43820901fa.2
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746466791; x=1747071591; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rp5gwNFNpAeyPfR6Z4xcDfjvEj1C0w2jRNIl1eWwJik=;
        b=ZwkWVYOaagzHleQEDhie2/xSxz39z0/lacCCUxBanxfxzv+WcQXDaWzA0ImveGI4RY
         WehU4wOBid9O8vi8oExatCyGciG3ifWeVhWyjL9ElRiN42ySiQfjkE1fMV8UZx36Dp41
         Fmxok6tB8+Pgx0tD00R2RkzUkfwHLwTIPm61g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466791; x=1747071591;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rp5gwNFNpAeyPfR6Z4xcDfjvEj1C0w2jRNIl1eWwJik=;
        b=fVOtTcgOrsNWmg4zjDyt64MtBkJFEQvQTHrmF7+AfuaM7NGCXhLG1FFzsRRRldLH7u
         aOfrFgX6xgASybFuGuMPM6Lt3966jV6/Nu/AwTsJW67x1ODTwQj/VkEQCs0jvS4tDtfK
         5IUfpeiPMWnpeyOTtJQQmSFbj5+WZlFCN+jv9mXqiiK+bCNXdunNpjTiLWwUCM29/qGj
         lauEFgHV/mwnto/HyALeKQsghsvYN9+g5e+PqU5Mf5BVolE/sK+n9O7RnYTLUbf7z7jR
         fwT0vFNX/iZ7KvuDr2WhvbwuBvKP27+wmrNFUx2Hlzv2881zTXOg1xnQ+41aS0Q7qLOp
         mtKA==
X-Forwarded-Encrypted: i=1; AJvYcCUiokZ+pzcUYoxbXim25sO/I7rr/JausS2pbkXnlz9ETTfDblkSaQi+QVIJ2faxsaXRh/c3XRoMFU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGHHNaNvuEJFJhg0vpxOL0SBDZxsVSmhUtxWnFNavuwXChvj2
	bgh6CbM59adsCpEc5C9ebJ9UNSVAx1/1EEmAWJAVpUpzWfs1BT3fgxoaOCQwaQWDEd+yccTHhAk
	Y/vR66NUCD0SaK6gTGr5DfJbRryXnkUq9Q3rb
X-Gm-Gg: ASbGncs8Qf3Nze8hH0v7EHtlHHgLwhves+m7MA5VVg10k07upUCIp0hgotNRrh2fLru
	ShjVq1e7dc96QJS8nd9dYNRqCu/3lboSJS550L9cEChuSZdrOd7BBNSkmEtx52Ms5EVLyqCeCX2
	Ygw2UY5FIA3ai2cTqG6o+jtsA=
X-Google-Smtp-Source: AGHT+IHZDoIB6DI0fnMe6/hlXV8MoM8eATY5T1YDIUyVYeK2CvJuoZLyT0gJ3nz59SXXnBbApixN42f5uDF/F1w49Qs=
X-Received: by 2002:a2e:be8d:0:b0:30c:50fc:fb98 with SMTP id
 38308e7fff4ca-3264f01680fmr783381fa.13.1746466791399; Mon, 05 May 2025
 10:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 5 May 2025 13:39:39 -0400
X-Gm-Features: ATxdqUE2jmKN9hjBkNnmjcR5o6NlAVafrvGW1N7suJo18XH6RGLRHTAPs1iqDmc
Message-ID: <CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com>
Subject: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
To: Bjorn Helgaas <helgaas@kernel.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, "'Cyril Brulebois" <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 
	"'Nicolas Saenz Julienne" <nsaenz@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bartosz.golaszewski@linaro.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bc57e4063466fc3b"

--000000000000bc57e4063466fc3b
Content-Type: text/plain; charset="UTF-8"

Hello,

I recently rebased to the latest Linux master

ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

and noticed that PCI is broken for
"drivers/pci/controller/pcie-brcmstb.c"  I've bisected this to the
following commit

2489eeb777af PCI/pwrctrl: Skip scanning for the device further if
pwrctrl device is created

which is part of the series [1].  The driver in pcie-brcmstb.c is
expecting the add_bus() method to be invoked twice per boot-up, but
the second call does not happen.  Not only does this code in
brcm_pcie_add_bus() turn on regulators, it also subsequently initiates
PCIe linkup.

If I revert the aforementioned commit, all is well.

FWIW, I have included the relevant sections of the PCIe DT we use at [2].

Sorry I did not observe this sooner...

Regards,
Jim Quinlan
Broadcom STB/CM



[1] https://lore.kernel.org/lkml/20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org/T/#t
[2]

pcie@1000110000 {
        reg = <0x10 0x110000 0x0 0x9130>;
        ...

        pci@0,0 {
                vpcie3v3-supply = <0x45>;
                vpcie12v-supply = <0x44>;
                reg = <0x0 0x0 0x0 0x0 0x0>;
                ranges;
                bus-range = <0x1 0xff>;
                compatible = "pciclass,0604";
                device_type = "pci";
                #address-cells = <0x3>;
                #size-cells = <0x2>;

                pci-ep@0,0 {
                        local-mac-address = [ 00 10 18 f0 35 55 ];
                        reg = <0x10000 0x0 0x0 0x0 0x0>;
                };
        };
}

--000000000000bc57e4063466fc3b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCVKr/azvIfCSvcjpj7kGS0sTNlSwRp
7olkpBqD2pl8MzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MDUxNzM5NTFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQBNF90zcSNpVil7xBA2cMytDbMeg93CEYITcTYhshYxGKnx6P1NsOtqUiBcvQuGFS5l
xuCGxkPJKFdZSpSCYhbx6EUsJKgMsXjLkpsNQAN0ZFdM8k4PuiJ0AzmvmzawwObOEYx99plBdtR8
vNLWjrigbeD3Ve8+c0wToJxTSfEOJ3zU69J7umquHXiKW3g03o5xtxUa5LttJj2lDxJ6HbCtxHik
GQTANuzeTcRQEFHOmngTru/LKKHf0hwY9B9oBcK9RVboKtK+9gJ6NvLRGCmsHBYqTBSQefsR4LCs
HZYr11bJMBVErts/OoQn9T812FFU1jWX1ik/A6XVSMN77rM6
--000000000000bc57e4063466fc3b--

