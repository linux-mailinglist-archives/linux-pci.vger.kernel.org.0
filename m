Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029D15CE5E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 13:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbfGBL05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 07:26:57 -0400
Received: from mout.web.de ([217.72.192.78]:57019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfGBL04 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 07:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562066812;
        bh=juqKN/utSp3mkklzu+oSJ9se0SQsDf+4EbbluIbW+U0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=JFjwoia8gyOm3B7tVtdGLdDc9lhxm11MTIUt2bokTWQdwhF89hC8MGUmijipIIgam
         y1vYv3C72PCEp360wnvHDkV6/YV1sTBEXWKcFjaA9+Ohd1dY/uRAeUVrSEXAWuyEDA
         yb1+ubDB34Zxh85ZPiLKYeTUNjhYoNDjaHuy30aI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSLn-1ihDCx0m0Z-010YqW; Tue, 02
 Jul 2019 13:26:52 +0200
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pci/proc: Use seq_puts() in show_device()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <a6b110cb-0d0e-5dc3-9ca1-9041609cf74c@web.de>
Date:   Tue, 2 Jul 2019 13:26:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j/yYiV3XfWA4kHGZcI33aLdYKuqQjEH0nantFwZKwvtGRkg2hQG
 HupyjTvUftjx43PwlPuEwWS8ZugGfcO+d0nGR76NbDJ2AjzEhl/foo0d+1aGD6mkmrYOVz3
 XrR83+gRiTuv0krYeS/uyWhNOKjqksgFbG27xTTK7R9l8AdPAuH1rpo7GGaomPqlAX7je3F
 7WWKdbsJcA/AfE1RVjS1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QwjPEUF+dsw=:UeGW4La/GqUNi8lqjnn0Vy
 WoC3yjA5KD6rNbpWnPdk68KD2k+NA6JZrCykYPbxHCau8uP1O4EobU/DIcahFfRAwAiFN7Hd8
 dVgDXxOx2kLQ1nsCxG3coKxAyDBcnjx+gl49kMXJwC9Sv4Sk3eYzpv7+tU9eAKBOBjh+eSJUE
 3EAbDWSCVA3RKywKPPL3zlz55y0lE0Xhj4olmXc/SqbCSrcx2EAKgxwkrIaUeyjCj51SoBcCJ
 B/kdHFhKqEpqJa3bzNcS4QjSlSAlgESolNM0LnQ7J0kqOSgSfzxpWdub4lX+k9dutzXt36pMP
 WMcBZNaX0O6TVggLYeODov11/qjBVxDuxez/5CLnARmCxs5EgMaSDH5fYBtr4uZAlvhZzGMcd
 2MyHrSXVw775d01usevMJC4CEN+/s8gnpoeFVln4D6zTGL2c/owp8ZKiyIRsiZw1Be0k+tg12
 krkeHpkRTqSVFA12SBtpoQFcKVGPp5gQ6eJR7qe4CAgsrQWqk96gJx7CW2YTfVVtXas0va8RF
 ULS4yA+vA0jPJ7UVMZBcTP427Qw32mfnjf367hhC+B4gkbjP7WYYoDKRz373yEYT4xYS28a/a
 YAjxtUor6qgPuTqzyft+1Ne9ALkOksVVKcq/sfxRBk2lqmFQDIaMOKqW0pZSTXStavh6UAf3P
 MJQPCkwDSrdvESIJ3axk+9lSB/xggjL8bqeFuR56FjlbmZfHI876ZHn7kyWRGCf1NxIokY2cf
 CsYB9VxCLHFeQdXveb7rroc3XMSGa3HP4bFlQgLYngpPy0R6Inlpvti9clWQPMpqDIfCgMpVf
 yFCZZbKoSH0XZUFIc6gQw+cVYJglS8/QGP+5NW06Z0pFkScFoQDUKKFSMHHkcAnYiIslorE8M
 xTI9aKyBHxc1PpzGYx8gDbUzC6L7ksGl+KDT6AirX/k9lcK9AUapMx5elP9hXzv46sbs+ozu2
 AeLDoXlm5U8RP1Nldzxu9IwDi9CrrgkAhOOt1zUAEMg8zPMwE92/ngHwQzuxDjpGnVj+2dBJV
 IzO79Jal05EX+fImJCfNZs7JyibnlNM+0H2RgDx8eFddcGQ3Xpo/cVG5QUKxxsCbnDHdTE2dy
 G0ExEjhnchLa4CbaWgvD8hI//JPUWAXhoVp
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 13:21:33 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 445b51db75b0..fe7fe678965b 100644
=2D-- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -377,7 +377,7 @@ static int show_device(struct seq_file *m, void *v)
 	}
 	seq_putc(m, '\t');
 	if (drv)
-		seq_printf(m, "%s", drv->name);
+		seq_puts(m, drv->name);
 	seq_putc(m, '\n');
 	return 0;
 }
=2D-
2.22.0

