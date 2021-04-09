Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6025E359941
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIJcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 05:32:14 -0400
Received: from mout.web.de ([217.72.192.78]:41525 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhDIJcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 05:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617960720;
        bh=mV7Gf0E4pKSxCBiYk5/r+b0Y2W8Sg8IWSbkx0NVisD4=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=POdMu8lLmhlvxwlvxXGZKhsjMH+UApJJs2/8lpXkL7r+e0k1CjQeqc4nizYH9OFwz
         H5q0sshhxZPYWONDawoA5vD7wfuJ1TRB8PzuFB0F312VoTDQyDKY9XZ6bOI4oyfG0M
         HTBiuu3bxGZG/20CpGkzFTyr8Nb2epcWaOygT32w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.111] ([178.12.13.154]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iH2-1lPJlM1bdk-00C9w1; Fri, 09
 Apr 2021 11:26:56 +0200
Subject: QCA6174 pcie wifi: Add pci quirks
From:   Ingmar Klein <ingmar_klein@web.de>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d74205a4-8a69-c383-e265-1ed5b8508422@web.de>
Message-ID: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
Date:   Fri, 9 Apr 2021 11:26:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d74205a4-8a69-c383-e265-1ed5b8508422@web.de>
Content-Type: multipart/mixed;
 boundary="------------F1B74CA691FACCFBE3B85674"
X-Provags-ID: V03:K1:chun0BMzlWK90Q9n2LVfo5mWcWjCg5VxjPKy81Az0Ifu/dlPx7S
 vduCgChCREtGnT8EMmfMFiO61cdz3UF4ljHeiEX9i+mUekkqSrf/ntTFuq2G9uWXqFaFqLw
 89QxxH899CORXezOwnywKVPV/EtsMmkVx6cQ7DxaNc/tzM03lh75IKfQll7hZtQyfSL5T9o
 +QsD5wbNAZXLgabu9oTyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sFKvg7aMoQc=:/b78TfJ2dxpfGAcXgytJ02
 bnHe9yua8++thjRFeaa8qJxv8Lv+N73yu/pe2TSTdkJmh08XnybcFNkMu5gfcodwpXEsRrmj/
 AgF+9rhKN3XdWTtGZZzn9/4ScjRzPykjDzUHl6U/slnnj/Rprbkqb9hBhkrxHSKYp2eKc75kz
 poi43Uf59tQifxYtWMEIjTM+qrppqa7zECDXB4JqJurFQz0PE974R1U5zLb08p0BFtUIUYaBi
 XmIuxpEOna12GL/LL3+lh3i3TNHFfPXTTGQfRWs25lBNxjheBRNYCs1akNMI8YYmSkDUuhn1r
 LVXmfq5UrYNdJnal+tnf08683fR89Q6XAUftn/tmR0HRt/fHqBs8pwXqID0W2KSSB8BECBybD
 WHWplUgcXRk3Sffzi6YA2F3qNMC9G8J7M2Bjj5xt82MVlh0dkWTtXKobYK5hyJKUxrILVMWKe
 ZH3N3enE4vf1KzKfg9nM3RiAvLQCQZ2ku9i3qZTdHvL5s5iFVCol1EOHutbQuhq/yQjet3X7a
 Z6KrlSGhHTBvl/uFfuEZeo0TS65kLz1BGRztyZ1Qq+cmztIreydOMUavzrF9H4D/3e11VEclW
 gbxXZMmLHQvcrSjM5pTAZr8rSHFzTk5y+rSIlQAg+smw9ancXfKYPQKIwXmftKSE/TpsfDGzC
 N5HwalFx7E4f9p0oscOZE3yhx2fFHbPzpcmFEpmnTAiMFJj79mvbFjD2HjFHpgudTU0eNGkps
 Eg8HtWkOxSz9hWgC4zLzdBNqvbDPtYqi6g1rYey4YpvvD/nO1hg2kbeTJqE6qxj8wxUffsyX2
 X/cSmgsaTNAOIVjfYEgFt1hxIVMV6BCteJGpNrkI7ggxC8vAlAPUb2sQU2LknDQYpOtV4pwNe
 Jw8CWpjN27l8FxMMKMjYjuyn4Gm1Or8xkY77zsZrM1ZafMtW45kfYKvZAD4P0l4740XhkwS8t
 5AgWctSr7H3nYb2WS4gbIb7wWrPPgZX2rXxQVKuh+frQ7mtXjfHVy20V0BzYTyyhnQZ0tQfq3
 mT94ST2kSRYaU4V/FAOtDr/0+yAw33DYWQe3xtoLg0uSQ+WmnJtrxtxugpQvy2xqhY1UlSz1V
 GZahHuuqTWazZScmvAoSddQaNG2memk2O/0Zc6y6xfSQeKEgVtaR8HJa2sl1k4LX2lGTKewcN
 Wdvp7uvamrKh6QfAvjP438iiPvdK1SclKRPH2oYLY8hNyPob8a3gQFKfGaZpZGLZhOUIE=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------F1B74CA691FACCFBE3B85674
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Edit: Retry, as I did not consider, that my mail-client would make this
party html.

Dear maintainers,
I recently encountered an issue on my Proxmox server system, that
includes a Qualcomm QCA6174 m.2 PCIe wifi module.
https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX

On system boot and subsequent virtual machine start (with passed-through
QCA6174), the VM would just freeze/hang, at the point where the ath10k
driver loads.
Quick search in the proxmox related topics, brought me to the following
discussion, which suggested a PCI quirk entry for the QCA6174 in the kerne=
l:
https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/

I then went ahead, got the Proxmox kernel source (v5.4.106) and applied
the attached patch.
Effect was as hoped, that the VM hangs are now gone. System boots and
runs as intended.

Judging by the existing quirk entries for Atheros, I would think, that
my proposed "fix" could be included in the vanilla kernel.
As far as I saw, there is no entry yet, even in the latest kernel sources.

Thank you very much!
Best regards,
Ingmar

--------------F1B74CA691FACCFBE3B85674
Content-Type: text/plain; charset=UTF-8;
 name="qualcomm_qca6174_add_pci_quirks.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qualcomm_qca6174_add_pci_quirks.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kvcXVpcmtz
LmMKaW5kZXggNzA2ZjI3YTg2YThlLi5lY2ZlODBlYzViOWMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL3F1aXJrcy5jCisrKyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCkBAIC0zNTg0LDYg
KzM1ODQsNyBAQCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9BVEhF
Uk9TLCAweDAwMzIsIHF1aXJrX25vX2J1c19yZXNldCk7CiBERUNMQVJFX1BDSV9GSVhVUF9I
RUFERVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAwM2MsIHF1aXJrX25vX2J1c19yZXNl
dCk7CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAw
eDAwMzMsIHF1aXJrX25vX2J1c19yZXNldCk7CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIo
UENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAwMzQsIHF1aXJrX25vX2J1c19yZXNldCk7CitE
RUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAwM2Us
IHF1aXJrX25vX2J1c19yZXNldCk7CiAKIC8qCiAgKiBSb290IHBvcnQgb24gc29tZSBDYXZp
dW0gQ044eHh4IGNoaXBzIGRvIG5vdCBzdWNjZXNzZnVsbHkgY29tcGxldGUgYSBidXMK
--------------F1B74CA691FACCFBE3B85674--
