Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B645A39AC37
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFCVDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFCVDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 17:03:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ABFC06174A
        for <linux-pci@vger.kernel.org>; Thu,  3 Jun 2021 14:02:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so6200829pjp.4
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=QSOLpmLbCwzetrCElB0kkluismAYJjcxqO7BeQz3kTc=;
        b=byL2sbaDoaleI5tgLRL35Q5XN0iw0eq7FYiK37C56yRiSq9KbvpQD3EDj7xhZp2FJf
         R7c8E2Vqg0JrPx3WTilUMl2w0mpAvwKBbaj74ik2aQUL4xXZD4kZBkvSimenQ9SZujg9
         Bqhqp4kRwntRVgVaeNIueKnYAvsklWQ98XovU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=QSOLpmLbCwzetrCElB0kkluismAYJjcxqO7BeQz3kTc=;
        b=EiI5r9gnlNPM+wDlCOnSysZW2JqLh9JLT50lv+doTr6+fcv8j8E0F2qOgw1Y5+UCf+
         /MTm5dZgaovvJ1lErHVFppLr8SmcTL0L9c1CPXN3kZ90urFEti04gc+tszCnui48AqCL
         vSN6PImgf7AQLpw/mZnp3rC1v7bHtrluvmuRmwAQI3RH5ecvdXtc7AVjz5LJXHYBaGxE
         zE3x3rr6dIUbv3+gNldpcoO/Zy/jjZdhAErgSqUyRMDKvgCD9ZUKnGisZY3JyjIyYmoV
         5o4XsxYy9RTmNyKLGvSIGa7F3n+zPbC0ap17rhB7G3QNMM0ktLQkLAyZFV3PYRHVOaYA
         +R7w==
X-Gm-Message-State: AOAM533Xv9EPA8U26gfeooB0QcBWiUg0x6O26OiBbkxrOtXrZfo7IQqc
        iSdvu17i68/fzYQJ9kAU7PsRHg==
X-Google-Smtp-Source: ABdhPJywnwhp//iwv1gF5kd5/fql9uctBp/xIpZxKVU0EgSl4LONc/dww6FseLVsVEZIVu1ouCEyBw==
X-Received: by 2002:a17:90b:3e89:: with SMTP id rj9mr1174641pjb.114.1622754117955;
        Thu, 03 Jun 2021 14:01:57 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z15sm17080pgu.71.2021.06.03.14.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 14:01:56 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210603205841.GA2139914@bjorn-Precision-5520>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <e4528fb0-324d-4bd5-5004-7ead22bc5622@broadcom.com>
Date:   Thu, 3 Jun 2021 14:01:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210603205841.GA2139914@bjorn-Precision-5520>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f6a56505c3e2e25b"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000f6a56505c3e2e25b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/3/21 1:58 PM, Bjorn Helgaas wrote:
> On Thu, Jun 03, 2021 at 10:30:37AM -0700, Florian Fainelli wrote:
>> On 6/3/21 10:23 AM, Bjorn Helgaas wrote:
>>> On Wed, May 26, 2021 at 10:03:47AM -0700, Florian Fainelli wrote:
>>>> On 5/25/21 2:18 PM, Bjorn Helgaas wrote:
>>>>> On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
>>>>>> The shutdown() call is similar to the remove() call except the former does
>>>>>> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
>>>>>> if it does.
>>>>>
>>>>> This doesn't explain why shutdown() is necessary.  "errors occur"
>>>>> might be a hint, except that AFAICT, many similar drivers do invoke
>>>>> pci_stop_root_bus() and pci_remove_root_bus() (several of them while
>>>>> holding pci_lock_rescan_remove()), without implementing .shutdown().
>>>>
>>>> We have to implement .shutdown() in order to meet a certain power budget
>>>> while the chip is being put into S5 (soft off) state and still support
>>>> Wake-on-WLAN, for our latest chips this translates into roughly 200mW of
>>>> power savings at the wall. We could probably add a word or two in a v2
>>>> that indicates this is done for power savings.
>>>
>>> "Saving power" is a great reason to do this.  But we still need to
>>> connect this to the driver model and the system-level behavior
>>> somehow.
>>>
>>> The pci_driver comment says @shutdown is to "stop idling DMA
>>> operations" and it hooks into reboot_notifier_list in kernel/sys.c.
>>> That's incorrect or at least incomplete because reboot_notifier_list
>>> isn't mentioned at all in kernel/sys.c, and I don't see the connection
>>> between @shutdown and reboot_notifier_list.
>>>
>>> AFAICT, @shutdown is currently used in this path:
>>>
>>>   kernel_restart_prepare or kernel_shutdown_prepare
>>>     device_shutdown
>>>       dev->bus->shutdown
>>>         pci_device_shutdown                     # pci_bus_type.shutdown
>>>           drv->shutdown
>>>
>>> so we're going to either reboot or halt/power-off the entire system,
>>> and we're not going to use this device again until we're in a
>>> brand-new kernel and we re-enumerate the device and re-register the
>>> driver.
>>>
>>> I'm not quite sure how either of those fits into the power-saving
>>> reason.  I guess going to S5 is probably via the kernel_power_off()
>>> path and that by itself doesn't turn off as much power to the PCIe
>>> controller as it could?  And this new .shutdown() method will get
>>> called in that path and will turn off more power, but will still leave
>>> enough for wake-on-LAN to work?  And when we *do* wake from S5,
>>> obviously that means a complete boot with a new kernel.
>>
>> Correct, the S5 shutdown is via kernel_power_off() and will turn off all
>> that we can in the PCIe root complex and its PHY, drop the PCIe link to
>> the end-point which signals that the end-point can enter its own suspend
>> logic, too. And yes, when we do wake-up from S5 it means booting a
>> completely new kernel. S5 is typically implemented in our chips by
>> keeping just a little bit of logic active to service wake-up events
>> (infrared remotes, GPIOs, RTC, etc.).
> 
> Which part of that does this patch change?  Is it that the new
> .shutdown() turns off more power than machine_power_off() does by
> itself?

Yes, with pcie-brcmstb.c providing a .shutdow() callback we have a
chance to turn off our PCIe PHY and the RC's digital clock which would
not be able to do otherwise.
-- 
Florian

--000000000000f6a56505c3e2e25b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDHG7gDNoanCGtqaNhjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNjU3MTBaFw0yMjA5MDUwNzA3MjNaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAu10WSl35INx8Ma97NH54zM3XKzx8Lo/KErWP5HPBtIxzYjBL20TDg9Jmnnbs
rZjwEVNKY30HiBRJcooDpalBATQpdw3kdYEgojrrXjVz4a+YaWhLbV0OwQ54QAkwKsdYTnuUX0B4
YLYGuUBDXYkcFWZv5BiAF4L97ClbTnUUCry8bhV9SP8b/tbivOhWUSjHLsQ9gEjuLhVId3Xgs9dA
TtoyOTJVs6HDth0+/13gxSrB3BwSY4wtw7EPHshswD1fzSV1fZf7QUQedadjH8BMBaKKseIieb6M
bhjsippX2btWEJOuUFS5RkK5HFFkzcGtIQd+gltZHQHohAcopF+cSwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIDZLMN77
IWw6rnhSvGm2V4nv3AowDQYJKoZIhvcNAQELBQADggEBADVdzyh3BQZiABHSdL7LQPNr6/6OQwg7
65j9Ggyr2Rdl2RnQIifKtGGodVlJ8e9XCYt5rCNU8PriYstIk4jlMJp6SziSN0CLE+A+FujmTqZJ
X8vEct7sdLXqdlBvR23TLvnkxbS3RwED7FDDTxpIv5j87o78e+wrZOPvDskdrYXVWGUu23xmd2IS
kYMLAXNeGrVe6HovEKCJPw07+B35iJvwdpZBXiti5hFa3q1L0+K5nGMpceIrj4dOOkSNB2ipHR6H
Q5HbB0UbWMkRv1PYpxf5eMjyDqxNigsE2JIFa1nk8ckA8hoTKbypCoALjcSuNqdZZyOnMBSKguHJ
Zz4bBBwxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxx
u4AzaGpwhramjYYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKLsOE+mKFZCBMmi
PcGd9LbdnN00MIKINUQXZkHRIjMcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIxMDYwMzIxMDIwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBu85dc43k6OeKufGtk1Q+jObZkXdu0jqZd
jCj0EXX4e27CWQUNMzpKC+WikGfCLN7Qf08dDvkwVuU10YmyPXZWcM4/UALQv3mlNsDjObWooGCP
/AADulhImTuzSTNO8XgSRHaf/QD9tVb3iKpjbfa0mI+vRdAAZ6awXPMWk/joA7mPBIoYQIP7zSFY
iX5R22bEpWI8YCvH+Y2xvaPNSf3sCQCTB2gyMrvPPQ62sBGY/mX6BDAtbeG3CtQRssqHKlxk83sq
gCuHhVDijQUGDn2t2BIh/H2rEpHvguBLZApc6QSaB0Zti12RsD/YwsUuxMcdvRhJcsFByu+Itiv9
2voT
--000000000000f6a56505c3e2e25b--
