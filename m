Return-Path: <linux-pci+bounces-37607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B14BBDF79
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1109018888FC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5627A11A;
	Mon,  6 Oct 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="wxWeq7FR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975D79EA;
	Mon,  6 Oct 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752600; cv=none; b=NFM3AShYkkK3OipBiP/WJRqyoh2r42X81mQkApHK3NFYCoxAWPXVi1nIVGuK4ftMoH3IGNFKprjlgWuyQ0mjkMGJ7fE7oZMdc6XmpbkGYCkTwP7+WlhphGV3q52V0radnXFIzLL3dXZFap1DojRVf1TbCeoImgNPr2R/rf8Y0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752600; c=relaxed/simple;
	bh=wLOwkkcujKvsrluRZvFTAl4mKaHbK7SU15aPs2NgEnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR0posZtEfcqXbe28daGYK/69FjYMYB2rH6Yb9ikvZbwziBZqb3vt/mu9Wksg0xhyrsmTeJrtiyxREXKM4TZ94lrrIZ1kUE05N4KHHRmv8Bvhi8RJYGIqmeFNgEEQtaxI6deQiTkgHCpRLNgzJj4TTjgqlYS456HFK+Z5GsXLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=wxWeq7FR; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759752589; x=1760357389; i=spasswolf@web.de;
	bh=2QGmngSUhQQcgbs2ImJWBmwZoPwLWpDcxEjwTdJk3AY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wxWeq7FRheFybnD6c/BYrw4Eckm68aKYsHeWuG8jeQev/LG3f3a092DVXGaaxk6u
	 fWAna1sJuwNVx+9nn0n+gv/rzQqi+rqwg6Qv+w6H8vynFXQsu3AIBk7t53I0tfD3F
	 kNLm+V6FI1jVhiG+m5LwBP6q6u2zKBAfU/NXousFTTwTwdYQAciSDXXIPwQrLrjFo
	 ZY6mZ9VxFkxtmQUNQbJmiZqhIYhqOW8LYowJlZ3PVmnV75T46tYbKOBkU6U/f+Ai0
	 r2CJnv5BZnEXneTEaGkIiuGD86C2vxVFwxdndmwz5j0slOKAVFbhVidW/XCt7q7K4
	 2oUTQ8uaVQV1257PgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M1JF8-1v7Ozf1BzW-004GA0; Mon, 06 Oct 2025 14:09:49 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [REGRESSION 01/04] Crash during resume of pcie bridge
Date: Mon,  6 Oct 2025 14:09:40 +0200
Message-ID: <20251006120944.7880-2-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251006120944.7880-1-spasswolf@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w9/gdy+hqZzuZ1j5hO58pdyAsgTwnTtPrCX4+vJAo6HeU/LVAbF
 6sqJVGaOPeF685Q1M7jOM6MxtXJia2eYZjT380uTIhyXy9gLrLwSuX2dKtWoYZ8YNMOz4v7
 hURTyr4j3rJcZ7QSiG8P6v9VpONjdHqn6mK8OqhkUXbP+4J6ZiSgpLLLRoLmaJZrCWYthUg
 mvXWHrV0VBBArJ9Z+pFPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kh11+aVAebw=;TJ5QRilpmoL9yzvq7gIZM3hj/6v
 m9AXSTjT2KGaSUmj2gYvAsb62IKtuefYSDAOJ/9LJnk1gPA93hX+NduXwS9bqGBuTF26LNRoM
 LOTLmKATXgDK8h/E44GLts9ncNgNsp1mbe9M5/B4ptimidLmpklWDS1va6VuB+Oz0a67u5Q2s
 c71eODu6+s+IbGVrNld2S20uiL6nZ4/EBmqR8QKo1txhCS8ZAMqDYraOof0BVVea8Mv7PhkHE
 kq9nMfbwML9ANLG4emCYMEH6VnAVgW481e8IuCnWdOQqYYqtkhSR4CiCc74mamRnv+LWJ8eOw
 JnW1TPfemfixQS22KCNiDixtDEAxUNn6NejjPp7hIgmBDt4vrKQLRN2BPZE/jsfWykG1QIb20
 NSe9P3vse7Fs0GDAJX5xCaOTRpbuxolS4ZCcmP0PogGIIrhwNI0JkayLrwoIeHvVgbb1No+e2
 h2jT8GJ89+2QSGyWF4ZUgdICwEMIVlxVlBFqunygAQio94Sn6Y60RaYpzhGyw+nLgPj8ypsaC
 s8yVLRuTXQ1oIRr4KvYKn9rhx0HH/WvqJjAJUvc7PcyvDVgg5yh53fug2CfsXssXQ8oqB9y+2
 VKhk/PSnys4z4lyH1AZv8g1zjhK13wKaqNvYacscuGRx4tvfLfLoch4qW5JhXKsAueWUguXen
 lXA+Us0FP4IEcEX6o/CNP8fDcFFPAdFE335hhvBpdvkcwjSH39mgd4/u1CE3c3iZFeijvvQ16
 cMkwPvk91hWtjcRsg94lv54hdg7W32qdcviNhjcOfdvNulwYHb0GWmArWQXM403Gdv8qLHMMC
 n51QTXkaMD5/ZVfHuZZz42ut/yKaNM8WMha8zuD8gz8Pg0jx1TcDBHRnF2iKbGYcUBZ5NH07N
 9FPGMfs2rvQRcNPbwPAsKgmRMDaqhVX9azYG6xFEnFXEv7TmUvHHj7VixBe/G9asB2yoMfzPN
 QbM/n264nj/mIg1G26rMjdv6En17TjHG1Ow23SLvttmlpn+mFmS9axRwEbZbiSrzL7fcQG/e+
 v8YXIVw7tM97LZO+rLLlYXMQf6/wWOiepEDPdPMOZc0PzlN8hWwMnKeg0tZPPYwmSBE+AGqBD
 SH22jLH67Ih1uEfL0uoUgLVAy2BbdH1z3viD+OYeEO483Alw3CjSPIUPhe+37kFl38fm8mEk1
 u1RfY6WdKhkPfI0/48Dt3wykG2iyO58c68GmsvZ0NWg6qmkUGILVIyDOEp8yoWn0ITFyDxt7W
 00b4b/bcFUblE/EJ25XD/v96gF3lMxEw5xpsTPrDcGXi0sjNdPzYeFoIrqYh8cKUSQ6aDz5yT
 jXY2knv//BEsOQNwWDx8ID+8YXojIpH43J7V6O7hVUAjxaO6vhCzJ6haXwHvE6cPxBhWpjh5n
 M3IMAe538+ukERKyvrpPxOHuPAgwO5wVlp6oxsRN7K4mNE2frNkfUlR+VAWI8SReZs7as6XfR
 stHenm0cQTcuRfyr8Ztuog2QzK81JsYj70QsVt24jJ46iMOveg4bfNW6FbZ9XSvD7utU/e1IE
 LGQS3LzJnQebmjSOnx97X2C7bGfOxH+lZOeO+2+trlb5AAyS5XC9f3S0i1glVyAP92/FrtC8f
 ijFtgttmERgZE8NLPFppP0SYrshKAehqX9YrvY3C+3TOMkqQMZ3mQD+FlH++gZGufYddiddSV
 zbZRafS12CzI1LCusCmYSeaY1ki58oqS7jG592UdMzEK43fC9Co9ugeIOx74AuqVMX/cP0lwZ
 cEe74T1KpPT2QJ6Ekh101tVYzdLQrWtEKiPUDLyW6UkuLpPj/z6zfyre1dzEwFK28jRrVvK7r
 +QzP5HpnNiWXaliXhHhP9Z0yxo+x44drE0IxoDEFSG7nIvRc+AEDiW88x5iiuQzG/SHxNJZdd
 KII9dgFZ1ni8IvZBCCCBTMEiFXzcJhc3ftbIjonXudmB+JFL6cqousvzxJDUR9cTcEkaq+vek
 bsXmw7ZWYh3tMM0jbTmniGiK+Ajlh1ymsXozyJoFYI3eE8gt/Pc8qwXuWO/ZD8U8Mc0jHAScQ
 QGpS4DzP4nAhkDDGx4dFTasHLQaZi/p30LCenQUhhA9wtpO8tCKk5lDrKV68hlUt23F4om9rT
 wEczF2O0vs7EczlVne/0l5wgKk6kmGkqsOmGd4LPoMcXItCsoAjTULhJNX0OeaXDz6jyxvIra
 WHbvOZNGwaczvcXYnJpxcMWtojeap9sVDZ8IIuR37Get1/nahOSmEwC6TYLwW3EHKpjTEyyfU
 QlBc2Wl7UBreUYljV8K9YJJ4Ev0IiqoKXLWviufZ2WrRQ03U5madkH5dJ02BpOL7q7y8gtDQf
 /LpGCjxdcMO7uU9JQWMpIWaHiT/BkgjmDn9QIfnJAaOQjYPPTDp+Mi4dvMopyZu99ogXjp3jd
 4XSELf4sdiPHVxnn81efsUPSOsPCx2UdlyZBPoZLeMtvH0cJ8NGY214VQ4Fdr+uEVHkCT5/vK
 B1Onz1pQWoL/BL1zgGHSBENOO318zn8ayt0KEPkQ1zEkUA4/gZRRvNUzySmWTp2RVpe9HrwKu
 /T8eJC3Ym/gYUDw55JTRZRSXRyBVvWthNd9Wu7ScOQqiteSiUm37VAAGzwtgmXGUq/XRWz4nv
 P+bxX9YYMacZmPGqBorcluyOkx/OVyJThM0OIhzyo4Yqpni2Gfukd8QoYSFT8yh2nNdpCfzcR
 Z7OKsTrV9vwqvNvMmLqtE533o7LJQAWVHCJ5dmu19LXHZfx8FmlYTJHlW1VAjsEEHgWrgO8SM
 El7/yc/saEqcK4mOGO0fcM1Qst7UyXLGltKGBSvvCavm9E4NQtGi5YJp7M0dGD8lN+MltZ0qV
 ZhF/RWwO8fhnUm5CBSsxyMlzpMEtexUwy/0NEWNifJqosD+GDEjHr9GhGPopsAKiGzbKhGKRq
 3pTr5Pjdexv5AVldJnRrAKofw8tWJeGlSP33kMtHG8NLEiygwD83tCDcUTtCpWCXld18gAyEA
 FT5iVthfjHy06wJaQaJoNWl6RrprDjxdkfAVrhKLWDo75IfreV9jzPhVEjcSzcIjZDKpFvQjx
 1Be3pOaXxZ9ihLjsobgctHBhDdO7gctiPkatuVJWtVk7OVoW9t2C2Co6bvfbahXQvZX58wVYv
 nD2uFWNldBPkbQOoKU7INwhJvzT+Gys/UziYzpn0xeTV+d7mmXw28Q/fOXqKwvZ6PcVUgwO/u
 9kDV+jWH1vHBojtN5zt88u4cFz4/CyerufGwKKafmgwP/7kOXx4RaGOQVkMerev9vropi1B61
 1I/1J9HrF/i2FBCb8FMYw8lSxLEFTm2ElKKWwPuvltARMi6o1xt5ZblWIQXsgB/Jm45oawFXB
 HPCI1qMWX+9Q1HT2jiDtzZvz6KH3jXWxT4JUZgac0qfVO9PDg3HHrTOKG9ClmcLKguOxKRdXU
 ZdY5zDvm5FZcIsMCXum2gK04Oi8r6hHTe4qJMAh+4sX/1TREF6EOaI9bSP/2uvYqJ4/ZJyL0G
 etbuhV3LDGqr7k9AUGvj6dmc4ou/8lM06RCeGoKtmYQ2clt2uKwEwa9U9M4r2nYVfAZrMhnTo
 o0jOjl2lqyMtQKkJGDnxZ+KMPxRcIdsvAfz8C5BMSvUiku+QlSpzp2WNHvTcvsbwEBUlB2bJm
 VE3DzDeOf/BKAMXrAWApsMe6I49mI0WZ2DEW/GoIqxJacmzYQ4nbr2/4xRKFaIXPrUqX/55Fp
 EWy7J7mCAi6jKN2KWxyTOI5NGZNnbhLIQKlqZev2WYLahvn8W8WXcRAdl9aWdX3qDXZUDcw2l
 HdM+jdAJzZT0GDs3+wWdrTQWfY+H9T9kV8KGG4IUnd8KXYXmxF2tFlzNc3wFkkJ+KPTVz4Usa
 3tCWfToVVeJ0RFEPK+vjEhy2cjrICFAA+4/tuTnHKdTVea89LAZMmHKZ4VmGfmz4AzwZJNZqz
 cF5Jt3i0lwUFpPnEayhtXABQiWf1k53EFvRyNE8J9bsLX4a6SXxHgHMwPDmG4zPvgPX776ikk
 r6SF06HFIvt4JHQU3DjlfZf8297JNn+czOxM2eigi1lALoXc3bVSpGRT3L0rgWk+3sa5zkC5x
 HcU8CsXdGkHVkgBYKEeC27xwhAoTbsN2j3Lpz5XKeczj5LbydAX/vViZsKVj+I8e+CTG2s520
 nPFjhzanRBDBkUwc2E3+/OdPGaGJx0M0CMQidkS7/G9z/93oGtFKN5ETPgcSt+h4OGfuOuyuD
 J47qCRr+DmNhMKWaC1ivDLUVk0U05dVs7TbqUXBYLvQaxmMA2/jSLED79EQ/K6m3hc8ntNDy+
 xEV1anPNcUlUVOOpMgKLXmyZT0nqHTkFNJHmpd2dMcdfytjcYqg3zIitMkrXAx4s0I2jdOWYT
 GOLL0QY57K6WOmbrZc3IHtu3Q9ZdtBpDf7q/MRhu0I9ellxpTwgBa0E0H4AyNT7KvO8WlTGJi
 9Fs6LA0xXxZL5zPctS9UpPoYiJt9z+wp1XEsINMn2BQjWo2c1xPIQVAQndPTam07NQoT0UYYw
 qTNabnrhiwkCxmnYHmef0fax0V9L8euBjrgH3vvh633O5CX/vNGKyR6kRqri9NO9um7G/EbnO
 4kVZRVGa8DR1pLhLPE7wogtmJ5xGSmNdqiWgMmX6NYCOMdHgOpzmpGbAlOjKtCen8NPPYcZwj
 rsrPqB9kbhdcONzevlg56sNYggHbbzl5DZCT5QO/qm0y46cs+d4J3RhDlX/OCxCQ5lX1ZuMQx
 yUTL1QqqUyXQJz3GickhX1N65s56RIylgRCJixxc2tats5/L+NRPyKS4+/qEersODQllWVOYi
 65SmIVrlh9VkaAvBcg5cT0LCI9PKQlpnC9S0XnodaJPlbAS3q++5r9K2PNqn/t7gb1tpK6VsK
 Fapvov7fnqN+i9VB1yuOKIwDSNckHDBXObL6ry+hA/PuGkRr6Wwzgt6ovhm6EtfOddgKBhSP6
 kEWg22ycdxjwojBVEnrGt+UB+KmaEaFnBZurnViwZCxvxu/EiKjXG2oLXGj4BrQL4REf85voQ
 tHCKtHIHU+YA9BbN4rF5xJENTXXvJyOtNbkz5wVnu4S+b3tjYUSEZ/pi84vpbG+qEcZHOZYjN
 RiZpsjBiYqb8Dat/wBb2WBb0erAmM3hFayTTmI+yntw2ftZs31UAcOmPL/HOeHhcFeIfNb2Y6
 4HTrInZcQmaI/LUcjBDPKFaPEqg/QnIXAIsdcw

To further debug the issue I inserted calls to dev_info() and printk() int=
o
the amdgpu suspend/resume code, and the acpi and pcie hotplug resume code.

This is the the patch used in kernel version=20
6.17.0-rc6-next-20250917-gpudebug-00021-gab98d880e3c8 (see list in previou=
s mail)
(on top of next-20250917)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a984ccd4a2a0..bc365c0dbe2f 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -514,46 +514,60 @@ static void acpi_bus_notify(acpi_handle handle, u32 =
type, void *data)
=20
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_BUS_CHECK\n", __func__, __LINE__);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_BUS_CHECK event\n");
 		break;
=20
 	case ACPI_NOTIFY_DEVICE_CHECK:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_CHECK\n", __func__, __LINE_=
_);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_CHECK event\n");
 		break;
=20
 	case ACPI_NOTIFY_DEVICE_WAKE:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_WAKE\n", __func__, __LINE__=
);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_WAKE event\n");
 		return;
=20
 	case ACPI_NOTIFY_EJECT_REQUEST:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_EJECT_REQUEST\n", __func__, __LINE=
__);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_EJECT_REQUEST event\n");
 		break;
=20
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_CHECK_LIGHT\n", __func__, _=
_LINE__);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_CHECK_LIGHT event\n");
 		/* TBD: Exactly what does 'light' mean? */
 		return;
=20
 	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_FREQUENCY_MISMATCH\n", __func__, _=
_LINE__);
 		acpi_handle_err(handle, "Device cannot be configured due "
 				"to a frequency mismatch\n");
 		return;
=20
 	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_BUS_MODE_MISMATCH\n", __func__, __=
LINE__);
 		acpi_handle_err(handle, "Device cannot be configured due "
 				"to a bus mode mismatch\n");
 		return;
=20
 	case ACPI_NOTIFY_POWER_FAULT:
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_POWER_FAULT\n", __func__, __LINE__=
);
 		acpi_handle_err(handle, "Device has suffered a power fault\n");
 		return;
=20
 	default:
+		printk(KERN_INFO "%s %d: acpi unknown event type\n", __func__, __LINE__=
);
 		acpi_handle_debug(handle, "Unknown event type 0x%x\n", type);
 		return;
 	}
=20
 	adev =3D acpi_get_acpi_dev(handle);
+	if (adev)
+		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
+	else
+		printk(KERN_INFO "%s %d: adev =3D NULL\n", __func__, __LINE__);
+	=09
=20
 	if (adev && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
 		return;
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 4e0583274b8f..9a7dc432b50d 100644
=2D-- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -539,6 +539,7 @@ static void acpi_pm_notify_handler(acpi_handle handle,=
 u32 val, void *not_used)
 	if (!adev)
 		return;
=20
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	mutex_lock(&acpi_pm_notifier_lock);
=20
 	if (adev->wakeup.flags.notifier_present) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece..0f6a16856119 100644
=2D-- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1167,6 +1167,7 @@ void acpi_os_wait_events_complete(void)
 	 * Make sure the GPE handler or the fixed event handler is not used
 	 * on another CPU after removal.
 	 */
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	if (acpi_sci_irq_valid())
 		synchronize_hardirq(acpi_sci_irq);
 	flush_workqueue(kacpid_wq);
@@ -1184,6 +1185,7 @@ static void acpi_hotplug_work_fn(struct work_struct =
*work)
 {
 	struct acpi_hp_work *hpw =3D container_of(work, struct acpi_hp_work, wor=
k);
=20
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	acpi_os_wait_events_complete();
 	acpi_device_hotplug(hpw->adev, hpw->src);
 	kfree(hpw);
@@ -1192,6 +1194,7 @@ static void acpi_hotplug_work_fn(struct work_struct =
*work)
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
 {
 	struct acpi_hp_work *hpw;
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	acpi_handle_debug(adev->handle,
 			  "Scheduling hotplug event %u for deferred handling\n",
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 065abe56f440..d53be7e0388d 100644
=2D-- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -251,6 +251,7 @@ static int acpi_scan_check_and_detach(struct acpi_devi=
ce *adev, void *p)
 {
 	struct acpi_scan_handler *handler =3D adev->handler;
 	uintptr_t flags =3D (uintptr_t)p;
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, p);
=20
@@ -314,6 +315,7 @@ static void acpi_scan_check_subtree(struct acpi_device=
 *adev)
 {
 	uintptr_t flags =3D ACPI_SCAN_CHECK_FLAG_STATUS;
=20
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	acpi_scan_check_and_detach(adev, (void *)flags);
 }
=20
@@ -369,6 +371,7 @@ static int acpi_scan_rescan_bus(struct acpi_device *ad=
ev)
 {
 	struct acpi_scan_handler *handler =3D adev->handler;
 	int ret;
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	if (handler && handler->hotplug.scan_dependent)
 		ret =3D handler->hotplug.scan_dependent(adev);
@@ -385,6 +388,7 @@ static int acpi_scan_device_check(struct acpi_device *=
adev)
 {
 	struct acpi_device *parent;
=20
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	acpi_scan_check_subtree(adev);
=20
 	if (!acpi_device_is_present(adev))
@@ -412,19 +416,24 @@ static int acpi_scan_device_check(struct acpi_device=
 *adev)
 static int acpi_scan_bus_check(struct acpi_device *adev)
 {
 	acpi_scan_check_subtree(adev);
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	return acpi_scan_rescan_bus(adev);
 }
=20
 static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
 {
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
+		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 		return acpi_scan_bus_check(adev);
 	case ACPI_NOTIFY_DEVICE_CHECK:
+		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 		return acpi_scan_device_check(adev);
 	case ACPI_NOTIFY_EJECT_REQUEST:
 	case ACPI_OST_EC_OSPM_EJECT:
+		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 		if (adev->handler && !adev->handler->hotplug.enabled) {
 			dev_info(&adev->dev, "Eject disabled\n");
 			return -EPERM;
@@ -441,6 +450,7 @@ void acpi_device_hotplug(struct acpi_device *adev, u32=
 src)
 	u32 ost_code =3D ACPI_OST_SC_NON_SPECIFIC_FAILURE;
 	int error =3D -ENODEV;
=20
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	lock_device_hotplug();
 	mutex_lock(&acpi_scan_lock);
=20
@@ -466,9 +476,10 @@ void acpi_device_hotplug(struct acpi_device *adev, u3=
2 src)
 		 * There may be additional notify handlers for device objects
 		 * without the .event() callback, so ignore them here.
 		 */
-		if (notify)
+		if (notify) {
+			dev_info(&adev->dev, "%s %d: calling notify =3D %px\n", __func__, __LI=
NE__, (void *) notify);
 			error =3D notify(adev, src);
-		else
+		} else
 			goto out;
 	}
 	switch (error) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acpi.c
index 6c62e27b9800..4f00e15e7759 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -168,6 +168,7 @@ static union acpi_object *amdgpu_atif_call(struct amdg=
pu_atif *atif,
 		atif_arg_elements[1].integer.value =3D 0;
 	}
=20
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	status =3D acpi_evaluate_object(atif->handle, NULL, &atif_arg,
 				      &buffer);
 	obj =3D (union acpi_object *)buffer.pointer;
@@ -559,6 +560,7 @@ static union acpi_object *amdgpu_atcs_call(struct amdg=
pu_atcs *atcs,
 		atcs_arg_elements[1].integer.value =3D 0;
 	}
=20
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	status =3D acpi_evaluate_object(atcs->handle, NULL, &atcs_arg, &buffer);
=20
 	/* Fail only if calling the method fails and ATIF is supported */
@@ -608,6 +610,7 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_=
atcs *atcs)
 	size_t size;
 	int err =3D 0;
=20
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	info =3D amdgpu_atcs_call(atcs, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
 		return -EIO;
@@ -682,6 +685,7 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu=
_device *adev)
 	if (!atcs->functions.pcie_dev_rdy)
 		return -EINVAL;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	info =3D amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICA=
TION, NULL);
 	if (!info)
 		return -EIO;
@@ -733,6 +737,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu=
_device *adev,
 	params.pointer =3D &atcs_input;
=20
 	while (retry--) {
+		dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 		info =3D amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST,=
 &params);
 		if (!info)
 			return -EIO;
@@ -798,6 +803,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_devi=
ce *adev,
 	params.length =3D sizeof(struct atcs_pwr_shift_input);
 	params.pointer =3D &atcs_input;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	info =3D amdgpu_atcs_call(atcs, ATCS_FUNCTION_POWER_SHIFT_CONTROL, &para=
ms);
 	if (!info) {
 		DRM_ERROR("ATCS PSC update failed\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 3893e6fc2f03..ed3063f09007 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -123,6 +123,7 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle=
 handle, int function,
 		atpx_arg_elements[1].integer.value =3D 0;
 	}
=20
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	status =3D acpi_evaluate_object(handle, NULL, &atpx_arg, &buffer);
=20
 	/* Fail only if calling the method fails and ATPX is supported */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_bios.c
index 00e96419fcda..542d039cfd42 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -272,6 +272,7 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle, u=
int8_t *bios,
 	atrm_arg_elements[1].type =3D ACPI_TYPE_INTEGER;
 	atrm_arg_elements[1].integer.value =3D len;
=20
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	status =3D acpi_evaluate_object(atrm_handle, NULL, &atrm_arg, &buffer);
 	if (ACPI_FAILURE(status)) {
 		DRM_ERROR("failed to evaluate ATRM got %s\n", acpi_format_exception(sta=
tus));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_device.c
index 0fdfde3dcb9f..bab504d1d24d 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5194,6 +5194,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol notify_clients)
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
 	int r =3D 0;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
 		return 0;
=20
@@ -5208,6 +5209,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol notify_clients)
 			return r;
 	}
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
 		dev_warn(adev->dev, "smart shift update failed\n");
=20
@@ -5286,6 +5288,7 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l notify_clients)
 	struct amdgpu_device *adev =3D drm_to_adev(dev);
 	int r =3D 0;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	if (amdgpu_sriov_vf(adev)) {
 		r =3D amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
@@ -5379,6 +5382,7 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l notify_clients)
 	amdgpu_vram_mgr_clear_reset_blocks(adev);
 	adev->in_suspend =3D false;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0))
 		dev_warn(adev->dev, "smart shift update failed\n");
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_drv.c
index ece251cbe8c3..165bd79fce82 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2795,6 +2795,7 @@ static int amdgpu_pmops_runtime_suspend(struct devic=
e *dev)
 	struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
 	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
 	int ret, i;
+	dev_info(dev, "%s %d\n", __func__, __LINE__);
=20
 	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE) {
 		pm_runtime_forbid(dev);
@@ -2874,6 +2875,7 @@ static int amdgpu_pmops_runtime_resume(struct device=
 *dev)
 	struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
 	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
 	int ret;
+	dev_info(dev, "%s %d\n", __func__, __LINE__);
=20
 	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v10_0.c
index 8841d7213de4..576ff827d80c 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7475,6 +7475,7 @@ static int gfx_v10_0_hw_init(struct amdgpu_ip_block =
*ip_block)
 {
 	int r;
 	struct amdgpu_device *adev =3D ip_block->adev;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	if (!amdgpu_emu_mode)
 		gfx_v10_0_init_golden_registers(adev);
@@ -7529,6 +7530,7 @@ static int gfx_v10_0_hw_init(struct amdgpu_ip_block =
*ip_block)
 static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	cancel_delayed_work_sync(&adev->gfx.idle_work);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v10_0.c
index d7499be8c4bf..fd4062e97e11 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -983,6 +983,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *i=
p_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
 	int r;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	adev->gmc.flush_pasid_uses_kiq =3D !amdgpu_emu_mode;
=20
@@ -1029,6 +1030,7 @@ static void gmc_v10_0_gart_disable(struct amdgpu_dev=
ice *adev)
 static int gmc_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	gmc_v10_0_gart_disable(adev);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/jpeg_v3_0.c
index d1a011c40ba2..a181c9965282 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -174,6 +174,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *i=
p_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
 	struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
@@ -212,6 +213,7 @@ static int jpeg_v3_0_suspend(struct amdgpu_ip_block *i=
p_block)
 {
 	int r;
=20
+	dev_info(ip_block->adev->dev, "%s %d\n", __func__, __LINE__);
 	r =3D jpeg_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
@@ -232,6 +234,7 @@ static int jpeg_v3_0_resume(struct amdgpu_ip_block *ip=
_block)
 {
 	int r;
=20
+	dev_info(ip_block->adev->dev, "%s %d\n", __func__, __LINE__);
 	r =3D amdgpu_jpeg_resume(ip_block->adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/=
amdgpu/navi10_ih.c
index 4cd325149b63..f33f5e2e6e53 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -320,6 +320,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *ad=
ev)
 	u32 ih_chicken;
 	int ret;
 	int i;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	/* disable irqs */
 	ret =3D navi10_ih_toggle_interrupts(adev, false);
@@ -385,6 +386,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *ad=
ev)
  */
 static void navi10_ih_irq_disable(struct amdgpu_device *adev)
 {
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	force_update_wptr_for_self_int(adev, 0, 8, false);
 	navi10_ih_toggle_interrupts(adev, false);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/=
amdgpu/sdma_v5_2.c
index 3bd44c24f692..78f60da4f498 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -697,6 +697,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *=
adev)
 {
 	int i, r;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	for (i =3D 0; i < adev->sdma.num_instances; i++) {
 		r =3D sdma_v5_2_gfx_resume_instance(adev, i, false);
 		if (r)
@@ -819,6 +820,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	int r =3D 0;
 	struct amdgpu_ip_block *ip_block;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	if (amdgpu_sriov_vf(adev)) {
 		sdma_v5_2_ctx_switch_enable(adev, false);
 		sdma_v5_2_enable(adev, false);
@@ -1404,6 +1406,7 @@ static int sdma_v5_2_hw_fini(struct amdgpu_ip_block =
*ip_block)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	sdma_v5_2_ctx_switch_enable(adev, false);
 	sdma_v5_2_enable(adev, false);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/vcn_v3_0.c
index d9cf8f0feeb3..b31062f212b5 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -367,6 +367,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip=
_block)
 	struct amdgpu_device *adev =3D ip_block->adev;
 	struct amdgpu_ring *ring;
 	int i, j, r;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	if (amdgpu_sriov_vf(adev)) {
 		r =3D vcn_v3_0_start_sriov(adev);
@@ -441,6 +442,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip=
_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
 	int i;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
@@ -474,6 +476,7 @@ static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip=
_block)
 	struct amdgpu_device *adev =3D ip_block->adev;
 	int r, i;
=20
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
 	r =3D vcn_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
@@ -498,6 +501,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_=
block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
 	int r, i;
+	dev_info(adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
 		r =3D amdgpu_vcn_resume(ip_block->adev, i);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpi=
php_glue.c
index 5b1f271c6034..e56ab308da20 100644
=2D-- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -484,6 +484,7 @@ static void enable_slot(struct acpiphp_slot *slot, boo=
l bridge)
 	struct pci_dev *dev;
 	struct pci_bus *bus =3D slot->bus;
 	struct acpiphp_func *func;
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	if (bridge && bus->self && hotplug_is_native(bus->self)) {
 		/*
@@ -494,10 +495,14 @@ static void enable_slot(struct acpiphp_slot *slot, b=
ool bridge)
 		 * as a Thunderbolt host controller.
 		 */
 		for_each_pci_bridge(dev, bus) {
-			if (PCI_SLOT(dev->devfn) =3D=3D slot->device)
+			dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
+			if (PCI_SLOT(dev->devfn) =3D=3D slot->device) {
+				dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 				acpiphp_native_scan_bridge(dev);
+			}
 		}
 	} else {
+		printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 		LIST_HEAD(add_list);
 		int max, pass;
=20
@@ -505,11 +510,15 @@ static void enable_slot(struct acpiphp_slot *slot, b=
ool bridge)
 		max =3D acpiphp_max_busnr(bus);
 		for (pass =3D 0; pass < 2; pass++) {
 			for_each_pci_bridge(dev, bus) {
-				if (PCI_SLOT(dev->devfn) !=3D slot->device)
+				dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
+				if (PCI_SLOT(dev->devfn) !=3D slot->device) {
+					printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 					continue;
+				}
=20
 				max =3D pci_scan_bridge(bus, dev, max, pass);
 				if (pass && dev->subordinate) {
+					dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
 					__pci_bus_size_bridges(dev->subordinate,
@@ -526,6 +535,7 @@ static void enable_slot(struct acpiphp_slot *slot, boo=
l bridge)
=20
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Assume that newly added devices are powered on already. */
+		dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 		if (!pci_dev_is_added(dev))
 			dev->current_state =3D PCI_D0;
 	}
@@ -544,6 +554,7 @@ static void enable_slot(struct acpiphp_slot *slot, boo=
l bridge)
 		}
 		pci_dev_put(dev);
 	}
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 }
=20
 /**
@@ -702,31 +713,43 @@ static void acpiphp_check_bridge(struct acpiphp_brid=
ge *bridge)
 	if (bridge->is_going_away)
 		return;
=20
-	if (bridge->pci_dev)
+	if (bridge->pci_dev) {
+		dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
 		pm_runtime_get_sync(&bridge->pci_dev->dev);
+	}
=20
+	dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
 	list_for_each_entry(slot, &bridge->slots, node) {
 		struct pci_bus *bus =3D slot->bus;
 		struct pci_dev *dev, *tmp;
+		dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
=20
 		if (slot_no_hotplug(slot)) {
-			; /* do nothing */
+			/* do nothing */
+			dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
 		} else if (device_status_valid(get_slot_status(slot))) {
 			/* remove stale devices if any */
 			list_for_each_entry_safe_reverse(dev, tmp,
-							 &bus->devices, bus_list)
+							 &bus->devices, bus_list) {
+				dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 				if (PCI_SLOT(dev->devfn) =3D=3D slot->device)
 					trim_stale_devices(dev);
+			}
=20
 			/* configure all functions */
+			dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
 			enable_slot(slot, true);
 		} else {
+			dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
 			disable_slot(slot);
 		}
 	}
=20
-	if (bridge->pci_dev)
+	if (bridge->pci_dev) {
 		pm_runtime_put(&bridge->pci_dev->dev);
+		dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
+	}
+		dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__);
 }
=20
 /*
@@ -760,6 +783,7 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
 void acpiphp_check_host_bridge(struct acpi_device *adev)
 {
 	struct acpiphp_bridge *bridge =3D NULL;
+	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	acpi_lock_hp_context();
 	if (adev->hp) {
@@ -799,6 +823,7 @@ static void hotplug_event(u32 type, struct acpiphp_con=
text *context)
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_BUS_CHECK\n", __func__, __LINE__);
 		acpi_handle_debug(handle, "Bus check in %s()\n", __func__);
 		if (bridge)
 			acpiphp_check_bridge(bridge);
@@ -809,6 +834,7 @@ static void hotplug_event(u32 type, struct acpiphp_con=
text *context)
=20
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		/* device check */
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_CHECK\n", __func__, __LINE_=
_);
 		acpi_handle_debug(handle, "Device check in %s()\n", __func__);
 		if (bridge) {
 			acpiphp_check_bridge(bridge);
@@ -824,19 +850,23 @@ static void hotplug_event(u32 type, struct acpiphp_c=
ontext *context)
=20
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
+		printk(KERN_INFO "%s %d: ACPI_NOTIFY_EJECT_REQUEST\n", __func__, __LINE=
__);
 		acpi_handle_debug(handle, "Eject request in %s()\n", __func__);
 		acpiphp_disable_and_eject_slot(slot);
 		break;
 	}
=20
 	pci_unlock_rescan_remove();
+	printk(KERN_INFO "%s %d:\n", __func__, __LINE__);
 	if (bridge)
 		put_bridge(bridge);
+	printk(KERN_INFO "%s %d:\n", __func__, __LINE__);
 }
=20
 static int acpiphp_hotplug_notify(struct acpi_device *adev, u32 type)
 {
 	struct acpiphp_context *context;
+	dev_info(&adev->dev, "%s %d: %s =3D %px\n", __func__, __LINE__, __func__=
, (void *) acpiphp_hotplug_notify);
=20
 	context =3D acpiphp_grab_context(adev);
 	if (!context)
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcieh=
p_core.c
index f59baa912970..8f90f91c0a07 100644
=2D-- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -266,6 +266,7 @@ static void pciehp_disable_interrupt(struct pcie_devic=
e *dev)
 	 * Disable hotplug interrupt so that it does not trigger
 	 * immediately when the downstream link goes down.
 	 */
+	dev_info(&dev->device, "%s %d\n", __func__, __LINE__);
 	if (pme_is_native(dev))
 		pcie_disable_interrupt(get_service_data(dev));
 }
@@ -273,6 +274,7 @@ static void pciehp_disable_interrupt(struct pcie_devic=
e *dev)
 #ifdef CONFIG_PM_SLEEP
 static int pciehp_suspend(struct pcie_device *dev)
 {
+	dev_info(&dev->device, "%s %d\n", __func__, __LINE__);
 	/*
 	 * If the port is already runtime suspended we can keep it that
 	 * way.
@@ -287,6 +289,7 @@ static int pciehp_suspend(struct pcie_device *dev)
 static int pciehp_resume_noirq(struct pcie_device *dev)
 {
 	struct controller *ctrl =3D get_service_data(dev);
+	dev_info(&dev->device, "%s %d\n", __func__, __LINE__);
=20
 	/* pci_restore_state() just wrote to the Slot Control register */
 	ctrl->cmd_started =3D jiffies;
@@ -317,6 +320,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev=
)
 static int pciehp_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl =3D get_service_data(dev);
+	dev_info(&dev->device, "%s %d\n", __func__, __LINE__);
=20
 	if (pme_is_native(dev))
 		pcie_enable_interrupt(ctrl);
@@ -328,6 +332,7 @@ static int pciehp_resume(struct pcie_device *dev)
=20
 static int pciehp_runtime_suspend(struct pcie_device *dev)
 {
+	dev_info(&dev->device, "%s %d\n", __func__, __LINE__);
 	pciehp_disable_interrupt(dev);
 	return 0;
 }
@@ -335,6 +340,7 @@ static int pciehp_runtime_suspend(struct pcie_device *=
dev)
 static int pciehp_runtime_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl =3D get_service_data(dev);
+	dev_info(&dev->device, "%s %d\n", __func__, __LINE__);
=20
 	/* pci_restore_state() just wrote to the Slot Control register */
 	ctrl->cmd_started =3D jiffies;


This gives as output when crashing (only the last few lines, which don not
appear in /var/log/kern.log, but are captured with netconsole)

The processess involved here are the following:

T254: [irq/40-ACPI:Event] (this is a threaded interrupt handler for ACPI e=
vents)
The other two processes are [kworker/mm_percpu_wq] workqueues.

2025-09-30T02:25:57.704378+02:00 [T254]evmisc-0132 ev_queue_notify_reques:=
 Dispatching Notify on [GPP0] (Device) Value 0x00 (Bus Check) Node 0000000=
017caa1c9
2025-09-30T02:25:57.704378+02:00 [T61442]acpi_bus_notify 517: ACPI_NOTIFY_=
BUS_CHECK
2025-09-30T02:25:57.704378+02:00 [T61442]acpi device:00: acpi_bus_notify 5=
67#012 SUBSYSTEM=3Dacpi#012 DEVICE=3D+acpi:device:00
2025-09-30T02:25:57.704378+02:00 [T61442]acpi device:00: acpi_hotplug_sche=
dule 1197#012 SUBSYSTEM=3Dacpi#012 DEVICE=3D+acpi:device:00
2025-09-30T02:25:57.704378+02:00 [T77816]acpi_hotplug_work_fn 1188
2025-09-30T02:25:57.704378+02:00 [T77816]acpi_os_wait_events_complete 1170
2025-09-30T02:25:57.704378+02:00 [T77816]acpi device:00: acpi_device_hotpl=
ug 453#012 SUBSYSTEM=3Dacpi#012 DEVICE=3D+acpi:device:00
2025-09-30T02:25:57.704378+02:00 [T77816]acpi device:00: acpi_device_hotpl=
ug 480: calling notify =3D ffffffffb8a24fc0#012 SUBSYSTEM=3Dacpi#012 DEVIC=
E=3D+acpi:device:00
2025-09-30T02:25:57.704378+02:00 [T77816]acpi device:00: acpiphp_hotplug_n=
otify 869: acpiphp_hotplug_notify =3D ffffffffb8a24fc0#012 SUBSYSTEM=3Dacp=
i#012 DEVICE=3D+acpi:device:00
2025-09-30T02:25:57.704378+02:00 [T77816]hotplug_event 826: ACPI_NOTIFY_BU=
S_CHECK
2025-09-30T02:25:57.704378+02:00 [T77816]pcieport 0000:00:01.1: acpiphp_ch=
eck_bridge 717#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1

So the problem as appears to be happening inside of acpiphp_check_bridge()=
:

static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
{
	struct acpiphp_slot *slot;

	/* Bail out if the bridge is going away. */
	if (bridge->is_going_away)
		return;

	if (bridge->pci_dev) {
		dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__); // This =
is the last reported line.
		pm_runtime_get_sync(&bridge->pci_dev->dev);
	}

	dev_info(&bridge->pci_dev->dev, "%s %d\n", __func__, __LINE__); // This l=
ine is not reported during a crash.


Bert Karwatzki



