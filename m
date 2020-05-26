Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE51E2417
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgEZOav (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 10:30:51 -0400
Received: from mout.web.de ([212.227.17.11]:39821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgEZOau (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 10:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590503436;
        bh=LTvGnCvacsKhwxG6no99uP2zREPyYqAbT4gjHDTiCDo=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=tCp+jYFErCwPgpLGF9Ud2wj8r1st88pHYAMt51IEeCs+UnEuEBzYuazUgww7IDB0b
         BIsJQhb0xe9A+eFfuh6VnyPSG24saZO+JJ+wBXvTlz9dKFhm3vXxiYZLCb4tnUuCK8
         GcjYRI4M8QTJ2joGgoXTVUApWbFy0CTCBlRqYDSc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudP2-1ivlUK2WIK-00zntr; Tue, 26
 May 2020 16:30:36 +0200
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Kangjie Lu <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Improve exception handling in
 qcom_pcie_probe()
To:     Qiushi Wu <wu000273@umn.edu>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c0e71850-a67b-2aac-7ddc-186f3850c087@web.de>
Date:   Tue, 26 May 2020 16:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uaAnp8RQwNdE+0ja7LvKxcJVKXYXo10dhh+a2vXz/p29Rlpefbb
 nJAc4jU2thbXbeSaZ61S4c+XrWPiR4iJCf9W+0LHjawrvKUqS9IXjuR6W2OkiRoS0cug3nd
 kYTYRsMedZ+EKtPJmMHTmBV5S+y/KQxrKoOuc7kHeEaBZA5KsZbu0dTtWK0sP5kC3siWYLB
 rdLQWb3B7AwMLnCrSLPcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GVR6XjNU5JY=:eFsWbXRGNZKCp4dJ2y/Dh5
 L8XVV2KggePAQVTFbTF3twzxOk/nu1z+tADBUr78zK/dxQRKQC/qlnZFwyr/abR4WaVtcWgcb
 uw6Z1g66QMqufV30ODUTISRxzukG7EGgiNGV4gL+uejUT4hJKCsIrijWjva1K3xTa0xzvoCKQ
 VXFCQOJJwZFOqzaVRqbCxTHNl++PGrx0xrbkwxrZfrJzHIDYpm+q/owJYT+/iE14wgRlbJOae
 /tSUXtnYs5bdJAhkdYNEvY4ZmjNxjMLofHA4Q8+8L1uOwRanALYRtwBy/j4QyY5ZjbQfBaaSE
 Ej0dCl0Lve4qPw9+kvSvCobGGyxo1IqjSOMQQnJBAudvlEwIHz64w2keJqvuy8Dv8Q2auRnse
 OTHQ+GN3ZNRt+H8DV/qElbTIdGXvsez+PhkU+HMpxjkOR4D7Qvl7xTu0chue5yFxUG31rVtu6
 sYPTILckkLd7pt6FXiYL69fn5nXjTY2rnlwL+mgbQA/Bqvn7SjHjhonjI96VNMszxu8e6zn0Z
 JNdfWCFHIvoFjWi6Ly9oipOdq9gIwFy0k386/4on7KAh1Hu+Q3C23OQMRZrkNfyP2jbtXMNvT
 39aXfVLXaanBBcMe71TpvVmlMuhK/hJfEjloiI7Wr5QZ/xjrqfviyb9Tmo34NKsQthtRNv+7l
 ArCZePXZ35k0LI0YSrQG0IH19ZttAy9P19x5Zto9x9T62/T+X3Kt19VRsf9pSGq+ZrgWwW9Zf
 HAqFByAPPWffxJ11ozekmkJCc8wyPZfd0y7wgkceTEUjjhePfu2p+kllknvTfKtfbp9vmq23p
 32yIDA3d0Zpo8BSM/d9DL2f2Vm7I+RBS/SnVspGfQChOQ4GlJwwBQunoVFiCqL3sgNrQf5drV
 OAEC2I5+43cDoIcFs/z4nWvLTJjO/7l9ZfDP4LtO+nBOP7ek2PKQeNOCqzGEb9wgk3/AytXT3
 reEVd74w+yg94Cz4W1YtRFmCAcOHTvOXem8vzyZbYT3z22fimUXaaXrRLrIgivE628mJpd74x
 djDR0acTZkshIt6FCSy5IBvg0/W4DC9LPv+31w/6bmZt/TEycG3gWvXIIGT6y0CFga6DFbHsc
 MGcmqwfK/anUj7Nr0pVnG7+DcMfYFAhAoP4whKNI2oa53malzrMvsKH7dQYzADaKtdxzjsQgU
 GofmS9N+ac1Fm3oWH9gJ1WK201jrN13/v6fT/bkTAlaLDrc0vNCW80WEKsIhhbO5AZBGwpoqI
 lebkxjVVz4Pb+hY+W
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please avoid a typo in the patch subject (by a possible alternative?).


> In function qcom_pcie_probe(), there are several error-handling problem.

Wording adjustments:
This function contained improvable implementation details according to
exception handling.


> because refcount will be increased even pm_runtime_get_sync() returns
> an error.

because the reference count will be increased despite of the failure.
Thus add the missed function call.


> 2. pm_runtime_disable() are called twice, =E2=80=A6
=E2=80=A6
Thus remove redundant function calls.

Regards,
Markus
