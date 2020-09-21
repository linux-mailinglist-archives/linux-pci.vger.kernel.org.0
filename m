Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2C427363A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 01:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgIUXLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 19:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUXLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 19:11:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA3C061755
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 16:11:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x14so14831175wrl.12
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mHoruSCyZR4aICiJOK7Oyc3GUtCT1YETmG8eqkML2Gg=;
        b=QKBdO2HyWrFJo0anOE7p59d0SMUl1Koh7vCzMjNiTV/igqaVwQVASeyxy7LbSu4Z0e
         yUV+lnGb+iHCzrfW8UVJnirCFDBCLgcQUGPRUFNCUIResuZFZRlIfgEIQBFoq3Ae7OXI
         uyS23b2h4r3XgsyPViV64KPWY6WF6HHakbFBnJv7VcrtkYJavMXN1DAbfA9Ztq9TH00G
         pX7Wci2C67rRWCX7xZAtKcHMNNgW1PYSVsPFbkBb9CcSMuPQ7g4CrMammYwzQMf3D7a/
         a6JGc4uOD9tONtBOP3+L/ezkLRegnPyaXTTDgEN4Wpuir3vSOVdE7b7neO/uul00g8Zu
         EZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mHoruSCyZR4aICiJOK7Oyc3GUtCT1YETmG8eqkML2Gg=;
        b=hCExcjVQjZNBg0c6e2wxveUNx33D07xr/OLvfH5P3VdCeksjr0a06Bkk5wz6RgP7IJ
         HtXXLq0Rk7eH2req8dcNmHGp95T0SyFcjVmdjzaU/4yoVGH+iJuxF7VTTGeAVl2EpGuf
         wm41MOvSyiCV87VeLc42Us5zS+ghewtQdVGsStysakxc9yAjx/0Se4IoXqHWiCdPWMv/
         adIJTvW5Ift/tvroqwneGkrpcRrpY2Ucv1MQ8pUCdbUNaQPRv0q4fDS52b3KGRJ4s/p5
         sJcHtB1xtvcaS3QLBlQZEYBkkS+cd9nKkA0rjQGZefXBW0+DQrEVIRkMYT/EMpfDdAhX
         CHwA==
X-Gm-Message-State: AOAM5316WquCvdfZtYw2RDZMWDaT3cAFYRBiLcunHLWKtNevx0zLe1n8
        mE+hqqVz3Lsem6rRt/pH0/V1rG5JoZnCYXU/c6IP/eOvO7Q=
X-Google-Smtp-Source: ABdhPJxtWOG/4ajINBRKKkNt712x8PYq4hQ3wl1GTbaZnR6+3sZrcv6ERqQp8RkkA9frdw0fq9gZd3lOj0sz1bFoeBw=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr2145851wrl.419.1600729866335;
 Mon, 21 Sep 2020 16:11:06 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 19:10:55 -0400
Message-ID: <CADnq5_PoDdSeOxGgr5TzVwTTJmLb7BapXyG0KDs92P=wXzTNfg@mail.gmail.com>
Subject: Enabling d3 support on hotplug bridges
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000010d0a805afdaf71d"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000010d0a805afdaf71d
Content-Type: text/plain; charset="UTF-8"

Hi,

Recent AMD laptops which have iGPU + dGPU have been non-functional on
Linux.  The issue is that the laptops rely on ACPI to control the dGPU
power and that is not happening because the bridges are hotplug
capable, and the current pci code does not allow runtime pm on hotplug
capable bridges.  This worked on previous laptops presumably because
the bridges did not support hotplug or they hit one of the allowed
cases.  The driver enables runtime power management, but since the
dGPU does not actually get powered down via the platform ACPI
controls, no power is saved, and things fall apart on resume leading
to an unusable GPU or a system hang.  To work around this users can
currently disable runtime pm in the GPU driver or specify
pcie_port_pm=force to force d3 on bridges.  I'm not sure what the best
solution for this is.  I'd rather not have to add device IDs to a
whitelist every time we release a new platform.  Suggestions?  What
about something like the attached patch work?

Alex

--00000000000010d0a805afdaf71d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-pci-allow-d3-on-hotplug-bridges-after-2018.patch"
Content-Disposition: attachment; 
	filename="0001-pci-allow-d3-on-hotplug-bridges-after-2018.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kfd53s5o0>
X-Attachment-Id: f_kfd53s5o0

RnJvbSAzYTA4Y2I2YWMzOGM0N2I5MjFiOGI2ZjMxYjAzZmNkOGYxM2M0MDE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMjEgU2VwIDIwMjAgMTg6MDc6MjcgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBwY2k6IGFsbG93IGQzIG9uIGhvdHBsdWcgYnJpZGdlcyBhZnRlciAyMDE4CgpOZXdlciBBTUQg
bGFwdG9wcyBoYXZlIGhvdHBsdWcgY2FwYWJlIGJyaWRnZXMgd2l0aCBkR1BVcyBiZWhpbmQgdGhl
bS4KSWYgZDMgaXMgZGlzYWJsZWQgb24gdGhlIGJyaWRnZSwgdGhlIGRHUFUgaXMgbmV2ZXIgcG93
ZXJlZCBkb3duIGV2ZW4KdGhvdWdoIHRoZSBkR1BVIGRyaXZlciBtYXkgdGhpbmsgaXQgaXMgYmVj
YXVzZSBwb3dlciBpcyBoYW5kbGVkIGJ5CnRoZSBwY2kgY29yZS4gIFRoaW5ncyBmYWxsIGFwYXJ0
IHdoZW4gdGhlIGRyaXZlciBhdHRlbXB0cyB0byByZXN1bWUKYSBkR1BVIHRoYXQgd2FzIG5vdCBw
cm9wZXJseSBwb3dlcmVkIGRvd24gd2hpY2ggbGVhZHMgdG8gaGFuZ3MuCgpCdWc6IGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzEyNTIKQnVnOiBodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xMjIyCkJ1ZzogaHR0cHM6
Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTMwNApTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9wY2kvcGNpLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3Bj
aS5jCmluZGV4IGE0NThjNDZkN2UzOS4uMTI5MjdkNWRmNGI5IDEwMDY0NAotLS0gYS9kcml2ZXJz
L3BjaS9wY2kuYworKysgYi9kcml2ZXJzL3BjaS9wY2kuYwpAQCAtMjg1Niw3ICsyODU2LDcgQEAg
Ym9vbCBwY2lfYnJpZGdlX2QzX3Bvc3NpYmxlKHN0cnVjdCBwY2lfZGV2ICpicmlkZ2UpCiAJCSAq
IGJ5IHZlbmRvcnMgZm9yIHJ1bnRpbWUgRDMgYXQgbGVhc3QgdW50aWwgMjAxOCBiZWNhdXNlIHRo
ZXJlCiAJCSAqIHdhcyBubyBPUyBzdXBwb3J0LgogCQkgKi8KLQkJaWYgKGJyaWRnZS0+aXNfaG90
cGx1Z19icmlkZ2UpCisJCWlmIChicmlkZ2UtPmlzX2hvdHBsdWdfYnJpZGdlICYmIChkbWlfZ2V0
X2Jpb3NfeWVhcigpIDw9IDIwMTgpKQogCQkJcmV0dXJuIGZhbHNlOwogCiAJCWlmIChkbWlfY2hl
Y2tfc3lzdGVtKGJyaWRnZV9kM19ibGFja2xpc3QpKQotLSAKMi4yNS40Cgo=
--00000000000010d0a805afdaf71d--
