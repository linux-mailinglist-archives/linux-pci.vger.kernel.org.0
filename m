Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2336A72CB4C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjFLQSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFLQSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 12:18:17 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6D199
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 09:18:16 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b15e510630so2748449a34.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2023 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686586695; x=1689178695;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iIaJqY9wVTvQTYDsCOHBUKFA6Cv88/l4gFHkzV4+vMQ=;
        b=XTYWYegPH4T64u3NGNqO1F0ZBU77C/B7KK1KrfCjYe/sAbhyYtPgiBhuAGzL8AwfGr
         l2z/g+xi+z6uIT+86Vuyq6FciRd8Cok8a9etU50wX3YkVTNqamON22KYzc/mE1kEVDcY
         KRpkA7nkJFNz0XcMYaX3xzqFQ3ufosLYclUrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586695; x=1689178695;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIaJqY9wVTvQTYDsCOHBUKFA6Cv88/l4gFHkzV4+vMQ=;
        b=BHrpOcc4TQQpk9F0OHdtGhYXpdjFfDQirupuO8OzQa7PHpnwimWL2woAyzWD4YO31T
         7BGSv1jfKcEwvEagr2b2IZszpy5lKF1akjlT8t+BQbIpUvKzZ7yTBYzO/u+EKpJGiULy
         m6O6Qe/okxoxXJtYdVISNmfePkWhM1/kle+50xwMaNW0KCSSzbttsF7bUl5WD6MLJfZ/
         NH71fO6yjTGNBwTl/UZ47E3mQ3id17OWwwdxg1ykP+155icyhZO8SeyvVt37FXuS0ZvL
         hdd9dp4Z7IyQuSvmsyeWBteiMiXEus4HdxUKUgRdZ/9uKFCzMfGNAYzb8SiOhRrX6b0G
         8U+w==
X-Gm-Message-State: AC+VfDzEWTxhX8Dg4550mbWdj54nJrTsc5EPgJCV5n4KXD3znGD+t0/f
        VPSFol7Fn9IHs4gCH3rhJlYPRA==
X-Google-Smtp-Source: ACHHUZ5+NKsK0ZnvkOjcWjBSIPKnVSvfZ5u3r2f3ENIGmmNCZBmvFsNhWfW/EULTP3MpOfPpFrpx9A==
X-Received: by 2002:a05:6830:1d83:b0:6b2:ad27:fcae with SMTP id y3-20020a0568301d8300b006b2ad27fcaemr6458260oti.29.1686586694927;
        Mon, 12 Jun 2023 09:18:14 -0700 (PDT)
Received: from [10.136.64.163] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id fe9-20020a05622a4d4900b003f9adf7c9fbsm3504299qtb.71.2023.06.12.09.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:18:13 -0700 (PDT)
Message-ID: <54572585-07ee-c201-aaca-62eed4175257@broadcom.com>
Date:   Mon, 12 Jun 2023 09:18:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] PCI: iproc: Use of_property_read_bool() for boolean
 properties
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230609193326.1963542-1-robh@kernel.org>
From:   Ray Jui <ray.jui@broadcom.com>
In-Reply-To: <20230609193326.1963542-1-robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dc532705fdf110c4"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000dc532705fdf110c4
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/2023 12:33 PM, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Ray Jui <ray.jui@broadcom.com>

Thanks!

--000000000000dc532705fdf110c4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YVhHgdTTB3aAzFyz4UFRLwxCzIG7d7GIiB9MoLImssS08R5WQ5EJCd1fAF6iefLupAn/plPmn2w0
GF8bLF/FhwOn8jObLW5pQiKhjQSv3QIDAQABo4IB1TCCAdEwDgYDVR0PAQH/BAQDAgWgMIGjBggr
BgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9j
YWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8v
b2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBE
MEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20v
cmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2Jh
bHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAfBgNVHREEGDAWgRRyYXku
anVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIScG7uNJuCYBQieQC+eonQS9tdkwDQYJKoZIhvcNAQEL
BQADggEBAGLwq/sDtwLmkAa5/UpIG4o5HA9EH7SaYi05EUlzrDdIeZsJnXDkxmG9144wNZBbndHx
nKXRnpJjCX4jhZeNQFyY4m5c9c8bMytO4zb8XUJIxCjqkhtukJtqHieEogwGsmZlpOxt6Ucc2JXg
6oTTbyITD4Bvn7cFb7EI2FBcT7K8bf8AvwtNLl/dKYtUA/nEvVhjqp0wsDL3t//Q3GTwGWZB41gf
LC04V6gD9TVFl7i/N48Gu8PzTt4Kt0SZvBr7kQ9PKi7DVyXe23Ou89QVflaja3bPjt2UZCyq0JxJ
Nu5SjFDWjKlBCzbLDGkCBlM4DpjAb0y4MyKOsiVv7vIxNlYxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwcAgHcg4j27cIp1UUwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIAIU6POvnvMFwmuoLQQKt9cLzh4+IbKqJIyU4lB4PdhuMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYxMjE2MTgxNVowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBEM8Ai6anxAN12yHHefVgjZvxeVaTKCfnQ2s/DRoxplGU2cAiamDmzmGv+XG8bOk7Zw7Ib
8FYybsYCGyZ1RLnUUCbMQx9gjgduQTVFtL3olL9d69BeABqcZq3fgJtjeUrxUmYLyukSTyGgoWqF
7R62RkPWY+NsJ0FdX/NvyAmWqPlKRSb1DnP55h8gFENaTHiFtSWSHMvxcIDuWno915lba6idrX38
T40lA0x/WUwm15Cc6XjASR0OktKZp23oNehOrR7P33pPEsdBxnbdfGJJf0eRrmHLnK9UW0EXAz99
ZSypFMTURWrNU6bxmQevZsGB0B1IFSp4O69iiGibko0j
--000000000000dc532705fdf110c4--
