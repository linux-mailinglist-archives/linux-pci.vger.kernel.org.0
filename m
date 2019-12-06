Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECF1155BC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 17:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLFQsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 11:48:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43347 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFQsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2019 11:48:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so2003372qke.10
        for <linux-pci@vger.kernel.org>; Fri, 06 Dec 2019 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nuu4/6H+vKwLOkuTuCM+dUsL/H4Z50x6v0A0wvZ2YYg=;
        b=DQwIrLHmpXq2YzCPESFGMcIGqWLE52yeMtMFM0X4XbR5ZfymWNwsXD3c1PU1FKpF6C
         ji6O9XwniUzGpduCuamnON2Nsb9+pgobNbbcEQSN27C7rtsOxHbd8lz2NzBgOewnZfA9
         qZRXNJUMKBz/zZLELp0MbFa+u9CRJUzAsQPvXTXVZIZWJUebBA2rZV7a44xlj7Vr52Qo
         RRHVSwNZ62RCZSH9dnlmQjnQzCQp/snEEQdWvM9LEj0B3y3b7GZP402sm8Kc+tURVx8/
         5HmT6bdjFnotAi/9L9g7/Ba+H1EUanm5WwuZaFBQB7TUJbic4itCJnOC9ezIkog4cehq
         XSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nuu4/6H+vKwLOkuTuCM+dUsL/H4Z50x6v0A0wvZ2YYg=;
        b=YZrfhibIjKflt3PIrS3K961BJ5gwUaA8sc1O16IKFSx1c4/sjQSfOi1vbM+HXMDwQo
         ZceFjrperuWwhYYoG3E2Sc2m9BYRoyJxKSzP5WY+r5p4m626p5BWqtnmAkSV/XKfQcaV
         WBD8YIotNphPfeoVJ0WFZD+suogr2CC592/DhATNaLi7W3Ca6C7Kb4LdShLKfTykS6Cb
         6gc/7EdTB6P8EW7CFW8lCFs4wWpHJHayWNvRK4QQPaazWAdUuhS8Io6f/cE75bm0OOEY
         +fwpqKgh7e2ncLjZ1Ky2OfQkmncQPDqOW7Vzd903mZdkVEp3VmWAeBf+IZpo7wF3GmnP
         N7jg==
X-Gm-Message-State: APjAAAUM1TOQ0hb98Fj/1feMGou8zU/GENQ6/VbauxBQucmDQPnv8Lvz
        dm+v4Borcqo+adhbAflMbrk23buhd02Pe+8sr3Q=
X-Google-Smtp-Source: APXvYqzQsFZqb6BzHQgy9xCtBJvS97Ywy4aer+7Fb1a4vfM4GenlNcuw8g6bIiUGAJHu4yp4ygeiLTQqyPR4UTmckxY=
X-Received: by 2002:ae9:e649:: with SMTP id x9mr14034022qkl.405.1575650914819;
 Fri, 06 Dec 2019 08:48:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2oMhJDxkU8TpFon4vzBiL5WrYv-zQNtYW8xbqaQLh2eS7bbg@mail.gmail.com>
 <20191206150837.GA98601@google.com>
In-Reply-To: <20191206150837.GA98601@google.com>
From:   Ranran <ranshalit@gmail.com>
Date:   Fri, 6 Dec 2019 18:48:24 +0200
Message-ID: <CAJ2oMhJqsSftJtSDt2fsjqhLT0qQDZkdgQUc4pusuy6TvCnSVA@mail.gmail.com>
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000011881505990bd1a0"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000011881505990bd1a0
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 6, 2019 at 5:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 06, 2019 at 08:09:48AM +0200, Ranran wrote:
> > On Fri, Nov 29, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> > > > On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=205701
>
> > I have tried to upgrade to latest kernel 5.4 (elrepo in centos), but
> > with this processor/board (system x3650, Xeon), it get hang during
> > kernel boot, without any error in dmesg, just keeps waiting for
> > nothing for couple of minutes and than drops to dracut.
>
> - I don't think you ever said exactly what the original failure mode
>   was.  You said DMA from an FPGA failed.  What is the specific
>   device?  How do you know the DMA fails?
>

Hi,
FPGA is Intel's Arria 10 device.
We know that DMA fails because on using signaltap/probing the DMA
transaction from FPGA to CPU's RAM we see that it stall, i.e. keep
waiting for the access to finish.
We don't observe any error in dmesg.


> - Re your v5.4 kernel testing, dracut is a user-space distro thing, so
>   it sounds like your hang is some sort of installation problem that I
>   can't really help you with.  Maybe there are troubleshooting hints
>   at https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html.

I know, that's quite frustrating. I tried to disable features using
kernel arguments noacpi, noapic, but it still freeze somewhere without
giving any error,

>   You may also be able to just drop a v5.4 kernel on your v4.18
>   system, at least for testing purposes.
>
What does it mean to drop 5.4 kernel on 4.18 kernel ?


> - Your comment #3 in bugzilla is a link to a Google Doc containing a
>   test module.  In the future, please attach things as plain text
>   attachments directly to the bugzilla.  There's an "Add attachment"
>   link immediately before the "Description" comment in bugzilla.  I
>   did it for you this time.
>
> - It looks like your test_module.c is a kernel module, and frankly
>   it's a mess.  Global variables that should be per-device, unused
>   variables (dma_get_mask() called for no reason), confused usage
>   (e.g., using both pci_dev_s and pPciDev), whitespace that appears
>   random, etc.  I suggest starting with Documentation/PCI/pci.rst and,
>   at least for this debugging effort, making it a self-contained
>   driver instead of splitting things between a kernel module and
>   user-space.
>

I've attached latest kernel module, which I hope will make it more
clear, I will try to make it a standalone test next time I'm in lab.

> - Your comment #4 is a link to a Google Doc containing lspci output.
>   I attached it to bugzilla directly for you.
>
> - You apparently didn't run lspci as root ("sudo lspci -vv"), so it
>   is missing a lot of information.
>
> - Your lspci doesn't match either of the dmesg logs.  Please make sure
>   all your logs are from the same machine in the same configuration.
>   For example, the first devices found by the kernel (from both
>   comments #1 and #2) are:
>
>     pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
>     pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
>     pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
>     pci 0000:00:02.2: [8086:3c06] type 01 class 0x060400
>     ...
>
>   But the lspci doesn't include 00:01.0, 00:02.0, or 00:02.2.  It
>   shows:
>
>     00:00.0 Host bridge: Intel Corporation Device 2020 (rev 04)
>     00:04.0 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
>     00:04.1 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
>     00:04.2 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
>     ...

 I will do it in lab tomorrow. Thanks.

--00000000000011881505990bd1a0
Content-Type: text/plain; charset="US-ASCII"; name="Fio.c.txt"
Content-Disposition: attachment; filename="Fio.c.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k3udq0m00>
X-Attachment-Id: f_k3udq0m00

I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiNpbmNs
dWRlIDxsaW51eC9wY2kuaD4NCiNpbmNsdWRlIDxsaW51eC9mcy5oPg0KI2luY2x1ZGUgPGxpbnV4
L3BvbGwuaD4NCiNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCiNpbmNsdWRlIDxsaW51eC9p
by5oPg0KI2luY2x1ZGUgPGxpbnV4L3dhaXQuaD4NCiNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0K
I2luY2x1ZGUgPGxpbnV4L2NkZXYuaD4NCiNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCiNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCg0KI2luY2x1ZGUgIi4uLy4uL2NvbW1vbi9GaW9J
b2N0bC5oIg0KI2luY2x1ZGUgIi4uLy4uL2NvbW1vbi9GaW9Jbi5oIg0KDQppbnQgRGV2aWNlSW5p
dChzdHJ1Y3QgcGNpX2RldiAqcFBjaURldik7DQoNCnN0YXRpYyBERUNMQVJFX1dBSVRfUVVFVUVf
SEVBRChzV2FpdFF1ZXVlUGFja2V0KTsNCg0Kc3RhdGljIHUzMiBzSW50ZXJydXB0RmxhZ1BhY2tl
dCA9IDA7DQoNCi8vc3RhdGljIHUzMiBzSW50ZXJydXB0Q291bnRlclBhY2tldCA9IDA7DQoNCnN0
YXRpYwl2b2lkKgkJc1ZpcnR1YWxLZXJuZWxDb21tb25CdWZmZXI7DQpzdGF0aWMgIHU2NAkJCXNQ
aHlzaWNhbEtlcm5lbENvbW1vbkJ1ZmZlcjsNCnN0YXRpYwl1MzIgICAgIAlzUGh5c2ljYWxCYXIx
QWRkcmVzczsNCnN0YXRpYwl1MzIJCQlzQmFyMUxlbmd0aDsNCnN0YXRpYwl2b2lkKgkJc1ZpcnR1
YWxCYXIxQWRkcmVzczsNCnN0YXRpYyAgZG1hX2FkZHJfdCAJc0RtYUhhbmRsZTsNCnN0cnVjdCAg
cGNpX2RldgkJKnBjaV9kZXZfczsNCg0KTU9EVUxFX0FVVEhPUigiWi5WIik7DQpNT0RVTEVfREVT
Q1JJUFRJT04oInJjbSIpOw0KTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KDQovKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKi8NCnU2NCBSZWFkV29yZDY0KHUzMiBPZmZzZXQpDQp7DQoJcmV0dXJuIGlv
cmVhZDY0KCh2b2lkKilzVmlydHVhbEJhcjFBZGRyZXNzICsgT2Zmc2V0KTsNCn0NCg0KLyoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKiovDQp2b2lkIFdyaXRlV29yZDY0KHUzMiBPZmZzZXQsIHU2NCBE
YXRhKQ0Kew0KCWlvd3JpdGU2NChEYXRhLCAodm9pZCopc1ZpcnR1YWxCYXIxQWRkcmVzcyArIE9m
ZnNldCk7DQp9DQoNCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0Kc3RhdGljIGxvbmcgRmlv
SW9jdGwgKHN0cnVjdCBmaWxlICpmaWxlLHVuc2lnbmVkIGludCBJb2N0bENvZGUsdW5zaWduZWQg
bG9uZyBJb2N0bFBhcmFtKQ0Kew0KCVdSSVRFX1dPUkQ2NF9SRVFVRVNUIFdyaXRlV29yZDY0UmVx
dWVzdDsNCglSRUFEX1dPUkQ2NF9SRVFVRVNUIFJlYWRXb3JkNjRSZXF1ZXN0Ow0KCUdFVF9QSFlT
SUNBTF9CVUZGRVJfUkVRVUVTVCBHZXRQaHlzaWNhbEJ1ZmZlclJlcXVlc3Q7DQoNCglpbnQgcmM7
DQoNCgkvL3ByaW50aygiLS0+IEZpb0lvY3RsLiBNaW5vcj0leFxuIiwgTWlub3IpOw0KDQoJc3dp
dGNoIChJb2N0bENvZGUpDQoJew0KCWNhc2UgV1JJVEVfV09SRDY0X1JFUVVFU1RfQ09ERToNCgkJ
Ly9jb3B5IHJlcXVlc3QgZnJvbSB1c2VyIHNwYWNlDQoJCXJjID0gY29weV9mcm9tX3VzZXIoJldy
aXRlV29yZDY0UmVxdWVzdCwgKHZvaWQqKUlvY3RsUGFyYW0sIHNpemVvZihXUklURV9XT1JENjRf
UkVRVUVTVCkpOw0KCQlpZiAocmMpDQoJCQlwcmludGsoIkZpb0lvY3RsOiBjb3B5X2Zyb21fdXNl
ciBmYWlsZWQuIHJjPTB4JXhcbiIsIHJjKTsNCgkJV3JpdGVXb3JkNjQgKFdyaXRlV29yZDY0UmVx
dWVzdC5PZmZzZXQsIFdyaXRlV29yZDY0UmVxdWVzdC5EYXRhKTsNCgkJcHJpbnRrICgiV1I6IDB4
JTA4eCB0byAgIDB4JTA4eFxuIiwgV3JpdGVXb3JkNjRSZXF1ZXN0LkRhdGEsIFdyaXRlV29yZDY0
UmVxdWVzdC5PZmZzZXQpOw0KCQlicmVhazsNCg0KCWNhc2UgUkVBRF9XT1JENjRfUkVRVUVTVF9D
T0RFOg0KCQkvL2NvcHkgcmVxdWVzdCBmcm9tIHVzZXIgc3BhY2UNCgkJcmMgPSBjb3B5X2Zyb21f
dXNlcigmUmVhZFdvcmQ2NFJlcXVlc3QsICh2b2lkKilJb2N0bFBhcmFtLCBzaXplb2YoUkVBRF9X
T1JENjRfUkVRVUVTVCkpOw0KCQlpZiAocmMpDQoJCQlwcmludGsoInJjbV9pb2N0bDogY29weV9m
cm9tX3VzZXIgZmFpbGVkLiByYz0weCV4XG4iLCByYyk7DQoJCVJlYWRXb3JkNjRSZXF1ZXN0LkRh
dGEgPSBSZWFkV29yZDY0IChSZWFkV29yZDY0UmVxdWVzdC5PZmZzZXQpOw0KCQlwcmludGsgKCJS
RDogMHglMDh4IGZyb20gMHglMDh4XG4iLCBSZWFkV29yZDY0UmVxdWVzdC5EYXRhLCBSZWFkV29y
ZDY0UmVxdWVzdC5PZmZzZXQpOw0KCQlyYyA9IGNvcHlfdG9fdXNlcigodm9pZCopSW9jdGxQYXJh
bSwgJlJlYWRXb3JkNjRSZXF1ZXN0LCBzaXplb2YoUkVBRF9XT1JENjRfUkVRVUVTVCkpOw0KCQlp
ZiAocmMpDQoJCQlwcmludGsoIkZpb0lvY3RsOiBjb3B5X3RvX3VzZXIgZmFpbGVkLiByYz0weCV4
XG4iLCByYyk7DQoJCWJyZWFrOw0KDQoJY2FzZSBJTlRFUlJVUFRfUkVRVUVTVF9DT0RFOg0KCQl3
YWl0X2V2ZW50X2ludGVycnVwdGlibGUoc1dhaXRRdWV1ZVBhY2tldCwgc0ludGVycnVwdEZsYWdQ
YWNrZXQgIT0gMCk7DQoJCXNJbnRlcnJ1cHRGbGFnUGFja2V0ID0gMDsNCgkJYnJlYWs7DQoNCglj
YXNlIEdFVF9QSFlTSUNBTF9CVUZGRVJfUkVRVUVTVF9DT0RFOg0KCQlyYyA9IGNvcHlfZnJvbV91
c2VyKCZHZXRQaHlzaWNhbEJ1ZmZlclJlcXVlc3QsICh2b2lkKilJb2N0bFBhcmFtLCBzaXplb2Yo
R0VUX1BIWVNJQ0FMX0JVRkZFUl9SRVFVRVNUKSk7DQoJCWlmIChyYykNCgkJCXByaW50aygicmNt
X2lvY3RsOiBjb3B5X2Zyb21fdXNlciBmYWlsZWQuIHJjPTB4JXhcbiIsIHJjKTsNCg0KCQlHZXRQ
aHlzaWNhbEJ1ZmZlclJlcXVlc3QuQWRkcmVzcyA9IHNQaHlzaWNhbEtlcm5lbENvbW1vbkJ1ZmZl
cjsNCg0KCQlyYyA9IGNvcHlfdG9fdXNlcigodm9pZCopSW9jdGxQYXJhbSwgJkdldFBoeXNpY2Fs
QnVmZmVyUmVxdWVzdCwgc2l6ZW9mKEdFVF9QSFlTSUNBTF9CVUZGRVJfUkVRVUVTVCkpOw0KCQlp
ZiAocmMpDQoJCQlwcmludGsoIkZpb0lvY3RsOiBjb3B5X3RvX3VzZXIgZmFpbGVkLiByYz0weCV4
XG4iLCByYyk7DQoJCWJyZWFrOw0KDQoJZGVmYXVsdDoNCgkJcHJpbnRrICgiRmlvSW9jdGw6IGlu
dmFsaWQgaW9jdGwgY29kZSgweCV4KVxuIiwgSW9jdGxDb2RlKTsNCgkJYnJlYWs7DQoJfQ0KCS8v
cHJpbnRrKCI8LS0gRmlvSW9jdGxcbiIpOw0KDQoJcmV0dXJuIDA7DQp9DQoNCi8qKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqLw0Kc3RhdGljIGludCBGaW9NbWFwKHN0cnVjdCBmaWxlKiBmbGlwLCBz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCnsNCglpbnQgcmM7DQoJDQoJcHJpbnRrKCItLT5G
aW9NbWFwXG4iKTsNCglyYyA9IHJlbWFwX3Bmbl9yYW5nZSAgKHZtYSwgDQoJCQkJCQkJdm1hLT52
bV9zdGFydCwgDQoJCQkJCQkJc1BoeXNpY2FsS2VybmVsQ29tbW9uQnVmZmVyID4+IFBBR0VfU0hJ
RlQsDQoJCQkJCQkJdm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0LA0KCQkJCQkJCXZtYS0+dm1f
cGFnZV9wcm90KTsNCg0KCWlmIChyYykNCgl7DQoJCXByaW50ayAoInJjbV9tbWFwOiByZW1hcF9w
YWdlX3JhbmdlIGZhaWxlZC4gcmM9JWRcbiIscmMpOw0KCQlyZXR1cm4gLTE7DQoJfQ0KCXByaW50
aygiPC0tRmlvTW1hcFxuIik7DQoNCglyZXR1cm4gMDsNCn0NCg0KLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovDQpzdGF0aWMgaXJxcmV0dXJuX3QgSXJxSGFuZGxlclBhY2tldCAoaW50IGlycSwg
dm9pZCAqZGF0YSkNCnsNCgl1MzIgU3RhdHVzOw0KDQoJcHJpbnRrICgiLS0+SXJxSGFuZGxlclxu
Iik7DQoJU3RhdHVzID0gUmVhZFdvcmQ2NChDQVJEX1NUQVRVU19PRkZTRVQpOw0KCWlmIChTdGF0
dXMgPT0wKQ0KCQlyZXR1cm4gSVJRX05PTkU7DQoNCglXcml0ZVdvcmQ2NChDQVJEX1NUQVRVU19P
RkZTRVQsIFN0YXR1cyk7DQoNCglzSW50ZXJydXB0RmxhZ1BhY2tldCA9IDE7DQoJd2FrZV91cF9p
bnRlcnJ1cHRpYmxlKCZzV2FpdFF1ZXVlUGFja2V0KTsNCglwcmludGsgKCI8LS1JcnFIYW5kbGVy
XG4iKTsNCg0KCXJldHVybiBJUlFfSEFORExFRDsNCn0NCg0KLyoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovDQpzdGF0aWMgaW50IEZpb09wZW4gKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBm
aWxlICpmbCkNCnsNCglwcmludGsoIi0tPkZpb09wZW5cbiIpOw0KDQoJcHJpbnRrKCI8LS1GaW9P
cGVuXG4iKTsNCglyZXR1cm4gMDsNCn0NCg0KLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQpz
dGF0aWMgaW50IEZpb1JlbGVhc2UgKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpm
bCkNCnsNCglwcmludGsoIi0tPkZpb1JlbGVhc2VcbiIpOw0KCXByaW50aygiPC0tRmlvUmVsZWFz
ZVxuIik7DQoJcmV0dXJuIDA7DQp9DQoNCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0Kc3Rh
dGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgc0Rydk9wZXJhdGlvbnMgPQ0Kew0KCXVubG9ja2Vk
X2lvY3RsOiBGaW9Jb2N0bCwNCglvcGVuCTogRmlvT3BlbiwNCglyZWxlYXNlIDogRmlvUmVsZWFz
ZSwNCgltbWFwCTogRmlvTW1hcCwNCglvd25lcgk6IFRISVNfTU9EVUxFDQp9Ow0KDQovKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8NCmludCBBbGxvY2F0ZUNvbW1vbkJ1ZmZlcihzdHJ1Y3QgcGNp
X2RldiAqcFBjaURldikNCnsNCglpbnQgcmM7DQoJdTY0IG1hc2s7DQoNCgkvKnJjPWRtYV9zZXRf
bWFza19hbmRfY29oZXJlbnQgKCZwUGNpRGV2LT5kZXYsIERNQV9CSVRfTUFTSyg2NCkpOw0KCWlm
IChyYyE9MCkNCgl7DQoJCXByaW50ayAoImRtYV9zZXRfbWFzayBmYWlsZWQuIHJjPSVkIixyYyk7
DQoJCXJldHVybiAtMTsNCgl9Ki8NCgltYXNrID0gZG1hX2dldF9tYXNrKCZwUGNpRGV2LT5kZXYp
Ow0KCXByaW50aygibWFrcz0weCVsbHhcbiIsIG1hc2spOw0KDQoJLy9Mb29wIGZvciBhbGxvY2F0
aW5nIGNvbW1vbiBidWZmZXIuIA0KCXNWaXJ0dWFsS2VybmVsQ29tbW9uQnVmZmVyID0gZG1hX2Fs
bG9jX2NvaGVyZW50ICgNCgkJCQkJCQkmcFBjaURldi0+ZGV2LCANCgkJCQkJCQlDT01NT05fQlVG
RkVSX1NJWkUsDQoJCQkJCQkJJnNEbWFIYW5kbGUsDQoJCQkJCQkJR0ZQX0tFUk5FTCB8IEdGUF9E
TUEpOw0KCWlmIChzVmlydHVhbEtlcm5lbENvbW1vbkJ1ZmZlciA9PSAweDApDQoJew0KCQlwcmlu
dGsoIkZpb0luaXQ6IHBoeXNfdG9fdmlydCBmYWlsZWRcbiIpOw0KCQlyZXR1cm4gLTE7DQoJfQ0K
DQoJc1BoeXNpY2FsS2VybmVsQ29tbW9uQnVmZmVyID0gKHU2NClzRG1hSGFuZGxlOw0KDQoJcHJp
bnRrKCJzUGh5c2ljYWxLZXJuZWxDb21tb25CdWZmZXI9MHglbGx4XG4iLCBzUGh5c2ljYWxLZXJu
ZWxDb21tb25CdWZmZXIpOw0KCSoodTMyKilzVmlydHVhbEtlcm5lbENvbW1vbkJ1ZmZlciA9IDB4
Q0FGRTJEQUQ7DQoNCglyZXR1cm4gMDsNCn0NCg0KDQovKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8NCmludCBEZXZpY2VJbml0IChzdHJ1Y3QgcGNpX2RldiAqcFBjaURldikNCnsNCglpbnQgZXJy
Ow0KCXUzMiBQYXR0ZXJuOw0KDQoJLy9lbmFibGUgZGV2aWNlDQoJaWYgKHBjaV9lbmFibGVfZGV2
aWNlKHBQY2lEZXYpKQ0KCXsNCgkJcHJpbnRrKCJGaW9Jbml0OiBwY2lfZW5hYmxlX2RldmljZSBm
YWlsZWRcbiIpOw0KCQlyZXR1cm4gLUVJTzsNCgl9DQoNCgkvL2ZpbmQgYmFzZSBhZGRyZXNzIG9m
IEJBUjENCglzUGh5c2ljYWxCYXIxQWRkcmVzcyA9IHBjaV9yZXNvdXJjZV9zdGFydChwUGNpRGV2
LCAxKTsNCglwcmludGsgKCJGaW9Jbml0OiBCYXIxQWRkcmVzcz0weCV4XG4iLCBzUGh5c2ljYWxC
YXIxQWRkcmVzcyk7DQoNCgkvL2ZpbmQgbGVuZ3RoIG9mIEJBUjENCglzQmFyMUxlbmd0aCA9IHBj
aV9yZXNvdXJjZV9sZW4gKHBQY2lEZXYsIDEpOw0KCXByaW50ayAoIkZpb0luaXQ6IGJhcjFfbGVu
X3M9MHgleFxuIiwgc0JhcjFMZW5ndGgpOw0KDQoJaWYgKHJlcXVlc3RfbWVtX3JlZ2lvbihzUGh5
c2ljYWxCYXIxQWRkcmVzcywgc0JhcjFMZW5ndGgsImZpbyIpPT1OVUxMKQ0KCXsNCgkJcHJpbnRr
ICgiRmlvSW5pdDogcmVxdWVzdF9tZW1fcmVnaW9uIGZhaWxlZFxuIik7DQoJCXJldHVybiAtMTsN
Cgl9DQoJDQoJLy9maW5kIHZpcnR1YWwgYWRkcmVzcyBvZiBiYXIxDQoJc1ZpcnR1YWxCYXIxQWRk
cmVzcyA9IGlvcmVtYXBfbm9jYWNoZShzUGh5c2ljYWxCYXIxQWRkcmVzcywgc0JhcjFMZW5ndGgp
Ow0KCXByaW50ayAoInZpcnR1YWxfYmFyMV9iYXNlX3M9MHglcFxuIiwgc1ZpcnR1YWxCYXIxQWRk
cmVzcyk7DQoNCgkvL1NldHRpbmdzDQoJZXJyID0gcmVxdWVzdF9pcnEocGNpX2Rldl9zLT5pcnEs
IElycUhhbmRsZXJQYWNrZXQsIElSUUZfU0hBUkVELCJmaW8iLCBwUGNpRGV2KTsNCglpZiAoZXJy
IT0wKQ0KCXsNCgkJcHJpbnRrKCJyZXF1ZXN0X2lycSAwIGZhaWxlZC5cbiIpOw0KCQlyZXR1cm4g
RUJVU1k7DQoJfQ0KDQoJUGF0dGVybj1SZWFkV29yZDY0IChGUEdBX1ZFUlNJT05fT0ZGU0VUKTsN
CglwcmludGsgKCJQYXR0ZXJuPTB4JTA4eFxuIixQYXR0ZXJuKTsNCg0KCWlmIChBbGxvY2F0ZUNv
bW1vbkJ1ZmZlcihwUGNpRGV2KSAhPSAwKQ0KCQlyZXR1cm4gLTE7DQoNCglyZXR1cm4gMDsNCn0N
Ci8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqLw0Kc3RhdGljIGludCBfX2luaXQgRmlvSW5pdCh2
b2lkKQ0Kew0KCWludCByYzsNCg0KCXByaW50aygiLS0+RmlvSW5pdFxuIik7DQoNCglyYz1yZWdp
c3Rlcl9jaHJkZXYoMCwgImZpbyIsICZzRHJ2T3BlcmF0aW9ucyk7DQoJaWYgKHJjIDwgMCkNCgl7
DQoJCXByaW50aygiRmlvSW5pdDogcmVnaXN0ZXJfY2hyZGV2IGZhaWxlZFxuIik7DQoJCXJldHVy
biAtMTsNCgl9DQoNCglwcmludGsoIk1ham9yPSVkXG4iLCByYyk7DQoNCgkvL2dldCBkZXZpY2Ug
YWNjb3JkaW5nIHRvIHZlbmRvcixkZXZpY2UNCglwY2lfZGV2X3MgPSBwY2lfZ2V0X2RldmljZShW
RU5ET1JfSUQsIERFVklDRV9JRCwgTlVMTCk7DQoJaWYgKHBjaV9kZXZfcyA9PSBOVUxMKQ0KCXsN
CgkJcHJpbnRrKCJyY21faW5pdDogcGNpX2dldF9kZXZpY2UgZmFpbGVkXG4iKTsNCgkJcmV0dXJu
IC1FTk9ERVY7DQoJfQ0KDQoJRGV2aWNlSW5pdChwY2lfZGV2X3MpOw0KDQoJcHJpbnRrKCI8LS1G
aW9Jbml0XG4iKTsNCglyZXR1cm4gMDsNCn0NCg0KLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiov
DQpzdGF0aWMgdm9pZCBfX2V4aXQgRmlvRXhpdCAodm9pZCkNCnsNCglwcmludGsoS0VSTl9BTEVS
VCAiLS0+RmlvRXhpdFxuIik7DQoNCgkvKmRtYV9mcmVlX2NvaGVyZW50KCZwY2lfZGV2X3MtPmRl
diwNCgkJCQkJCUNPTU1PTl9CVUZGRVJfU0laRSwNCgkJCQkJCXNWaXJ0dWFsS2VybmVsQ29tbW9u
QnVmZmVyLA0KCQkJCQkJc0RtYUhhbmRsZSk7Ki8NCgkJCQkJCQ0KCXByaW50ayhLRVJOX0FMRVJU
ICI8LS1GaW9FeGl0XG4iKTsNCn0NCg0KbW9kdWxlX2luaXQoRmlvSW5pdCk7DQptb2R1bGVfZXhp
dChGaW9FeGl0KTsNCg0K
--00000000000011881505990bd1a0--
